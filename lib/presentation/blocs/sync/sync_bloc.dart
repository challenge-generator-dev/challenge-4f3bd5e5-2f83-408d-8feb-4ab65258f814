import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:payment_app/domain/entities/entities.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app/domain/usecases/sync_transactions_usecase.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions_usecase.dart';
import 'package:payment_app/core/network/connectivity_service.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'sync_event.dart';
import 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final SyncTransactionsUseCase syncTransactionsUseCase;
  final GetPendingTransactionsUseCase getPendingTransactionsUseCase;
  final TransactionRepository transactionRepository;
  final ConnectivityService connectivityService;
  
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _periodicSyncTimer;
  static const int maxRetries = 3;
  static const Duration defaultSyncInterval = Duration(minutes: 5);

  SyncBloc({
    required this.syncTransactionsUseCase,
    required this.getPendingTransactionsUseCase,
    required this.transactionRepository,
    required this.connectivityService,
  }) : super(const SyncState()) {
    on<SyncStarted>(_onSyncStarted);
    on<SyncRequested>(_onSyncRequested);
    on<SyncCompleted>(_onSyncCompleted);
    on<SyncFailed>(_onSyncFailed);
    on<NetworkStatusChanged>(_onNetworkStatusChanged);
    on<RetrySyncRequested>(_onRetrySyncRequested);
    on<PendingTransactionsLoaded>(_onPendingTransactionsLoaded);
    on<SchedulePeriodicSync>(_onSchedulePeriodicSync);
    on<CancelPeriodicSync>(_onCancelPeriodicSync);
    on<ForceFullSync>(_onForceFullSync);
    on<SyncPaused>(_onSyncPaused);
    on<SyncResumed>(_onSyncResumed);

    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    _connectivitySubscription = connectivityService.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        final isConnected = connectivityService.isConnected(results);
        add(NetworkStatusChanged(isConnected: isConnected));
      },
    );
  }

  Future<void> _onSyncStarted(
    SyncStarted event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(
      subState: SyncSubState.loading,
      isSyncing: true,
      clearError: true,
    ));

    final connectivityResult = await connectivityService.checkConnectivity();
    final isConnected = connectivityService.isConnected(connectivityResult);

    if (!isConnected) {
      emit(state.copyWith(
        subState: SyncSubState.offline,
        isConnected: false,
        isSyncing: false,
      ));
      return;
    }

    add(const SyncRequested());
  }

  Future<void> _onSyncRequested(
    SyncRequested event,
    Emitter<SyncState> emit,
  ) async {
    if (state.isSyncing) {
      return;
    }

    emit(state.copyWith(
      subState: SyncSubState.syncing,
      isSyncing: true,
      clearError: true,
      progressPercentage: 0.0,
    ));

    final pendingResult = await getPendingTransactionsUseCase(const GetPendingTransactionsParams());
    
    await pendingResult.fold(
      (failure) async {
        emit(state.copyWith(
          subState: SyncSubState.failure,
          errorMessage: _mapFailureToMessage(failure),
          isSyncing: false,
        ));
      },
      (pendingTransactions) async {
        if (pendingTransactions.isEmpty) {
          emit(state.copyWith(
            subState: SyncSubState.success,
            totalPending: 0,
            totalSynced: 0,
            progressPercentage: 100.0,
            isSyncing: false,
            lastSyncTime: DateTime.now(),
            lastSyncStatus: SyncStatus.synced,
          ));
          return;
        }

        emit(state.copyWith(
          pendingTransactions: pendingTransactions,
          totalPending: pendingTransactions.length,
        ));

        final syncResult = await syncTransactionsUseCase(const SyncTransactionsParams());
        
        await syncResult.fold(
          (failure) async {
            emit(state.copyWith(
              subState: SyncSubState.failure,
              errorMessage: _mapFailureToMessage(failure),
              isSyncing: false,
            ));
          },
          (syncedTransactions) async {
            add(SyncCompleted(syncedTransactions: syncedTransactions));
          },
        );
      },
    );
  }

  Future<void> _onSyncCompleted(
    SyncCompleted event,
    Emitter<SyncState> emit,
  ) async {
    final totalTransactions = state.pendingTransactions.length;
    final syncedCount = event.syncedTransactions.length;
    final failedCount = totalTransactions - syncedCount;
    
    final updatedPending = state.pendingTransactions
        .where((t) => !event.syncedTransactions.any((s) => s.id == t.id))
        .toList();

    emit(state.copyWith(
      subState: SyncSubState.success,
      pendingTransactions: updatedPending,
      syncedTransactions: event.syncedTransactions,
      totalPending: updatedPending.length,
      totalSynced: syncedCount,
      totalFailed: failedCount,
      progressPercentage: 100.0,
      isSyncing: false,
      lastSyncTime: DateTime.now(),
      lastSyncStatus: SyncStatus.synced,
      retryCount: 0,
    ));
  }

  Future<void> _onSyncFailed(
    SyncFailed event,
    Emitter<SyncState> emit,
  ) async {
    final newRetryCount = state.retryCount + 1;
    
    if (newRetryCount < maxRetries) {
      emit(state.copyWith(
        subState: SyncSubState.syncing,
        errorMessage: event.errorMessage,
        retryCount: newRetryCount,
        totalFailed: event.failedCount,
      ));
      
      await Future.delayed(Duration(seconds: newRetryCount * 2));
      add(const RetrySyncRequested());
    } else {
      emit(state.copyWith(
        subState: SyncSubState.failure,
        errorMessage: 'Sincronización fallida después de $maxRetries intentos: ${event.errorMessage}',
        retryCount: newRetryCount,
        isSyncing: false,
      ));
    }
  }

  Future<void> _onNetworkStatusChanged(
    NetworkStatusChanged event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(isConnected: event.isConnected));

    if (event.isConnected && state.hasPendingTransactions && !state.isSyncing) {
      add(const SyncRequested());
    } else if (!event.isConnected) {
      emit(state.copyWith(subState: SyncSubState.offline));
    }
  }

  Future<void> _onRetrySyncRequested(
    RetrySyncRequested event,
    Emitter<SyncState> emit,
  ) async {
    if (!state.isConnected) {
      emit(state.copyWith(subState: SyncSubState.offline));
      return;
    }

    emit(state.copyWith(
      subState: SyncSubState.syncing,
      isSyncing: true,
      clearError: true,
    ));

    final syncResult = await syncTransactionsUseCase(const SyncTransactionsParams());
    
    await syncResult.fold(
      (failure) async {
        add(SyncFailed(
          errorMessage: _mapFailureToMessage(failure),
          failedCount: state.totalPending,
        ));
      },
      (syncedTransactions) async {
        add(SyncCompleted(syncedTransactions: syncedTransactions));
      },
    );
  }

  Future<void> _onPendingTransactionsLoaded(
    PendingTransactionsLoaded event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(
      pendingTransactions: event.pendingTransactions,
      totalPending: event.pendingTransactions.length,
    ));
  }

  void _onSchedulePeriodicSync(
    SchedulePeriodicSync event,
    Emitter<SyncState> emit,
  ) {
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = Timer.periodic(
      event.interval,
      (_) {
        if (state.isConnected && state.hasPendingTransactions) {
          add(const SyncRequested());
        }
      },
    );
  }

  void _onCancelPeriodicSync(
    CancelPeriodicSync event,
    Emitter<SyncState> emit,
  ) {
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = null;
  }

  Future<void> _onForceFullSync(
    ForceFullSync event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(
      pendingTransactions: [],
      syncedTransactions: [],
      totalPending: 0,
      totalSynced: 0,
      totalFailed: 0,
      retryCount: 0,
      clearError: true,
    ));

    add(const SyncStarted());
  }

  void _onSyncPaused(
    SyncPaused event,
    Emitter<SyncState> emit,
  ) {
    emit(state.copyWith(
      subState: SyncSubState.paused,
      isSyncing: false,
    ));
    _periodicSyncTimer?.cancel();
  }

  void _onSyncResumed(
    SyncResumed event,
    Emitter<SyncState> emit,
  ) {
    if (state.isConnected && state.hasPendingTransactions) {
      add(const SyncRequested());
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Error del servidor: ${failure.message}';
    } else if (failure is NetworkFailure) {
      return 'Error de conexión: ${failure.message}';
    } else if (failure is CacheFailure) {
      return 'Error de caché: ${failure.message}';
    } else if (failure is ValidationFailure) {
      return 'Error de validación: ${failure.message}';
    }
    return 'Error desconocido en la sincronización';
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _periodicSyncTimer?.cancel();
    return super.close();
  }
}