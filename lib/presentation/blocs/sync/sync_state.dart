import 'package:equatable/equatable.dart';
import 'package:payment_app/domain/entities/entities.dart';

enum SyncSubState {
  initial,
  loading,
  syncing,
  success,
  failure,
  offline,
  paused,
}

class SyncState extends Equatable {
  final SyncSubState subState;
  final List<TransactionEntity> pendingTransactions;
  final List<TransactionEntity> syncedTransactions;
  final int totalPending;
  final int totalSynced;
  final int totalFailed;
  final bool isConnected;
  final String? errorMessage;
  final DateTime? lastSyncTime;
  final double progressPercentage;
  final bool isSyncing;
  final int retryCount;
  final SyncStatus? lastSyncStatus;

  const SyncState({
    this.subState = SyncSubState.initial,
    this.pendingTransactions = const [],
    this.syncedTransactions = const [],
    this.totalPending = 0,
    this.totalSynced = 0,
    this.totalFailed = 0,
    this.isConnected = true,
    this.errorMessage,
    this.lastSyncTime,
    this.progressPercentage = 0.0,
    this.isSyncing = false,
    this.retryCount = 0,
    this.lastSyncStatus,
  });

  SyncState copyWith({
    SyncSubState? subState,
    List<TransactionEntity>? pendingTransactions,
    List<TransactionEntity>? syncedTransactions,
    int? totalPending,
    int? totalSynced,
    int? totalFailed,
    bool? isConnected,
    String? errorMessage,
    DateTime? lastSyncTime,
    double? progressPercentage,
    bool? isSyncing,
    int? retryCount,
    SyncStatus? lastSyncStatus,
    bool clearError = false,
    bool clearLastSyncTime = false,
  }) {
    return SyncState(
      subState: subState ?? this.subState,
      pendingTransactions: pendingTransactions ?? this.pendingTransactions,
      syncedTransactions: syncedTransactions ?? this.syncedTransactions,
      totalPending: totalPending ?? this.totalPending,
      totalSynced: totalSynced ?? this.totalSynced,
      totalFailed: totalFailed ?? this.totalFailed,
      isConnected: isConnected ?? this.isConnected,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lastSyncTime: clearLastSyncTime ? null : (lastSyncTime ?? this.lastSyncTime),
      progressPercentage: progressPercentage ?? this.progressPercentage,
      isSyncing: isSyncing ?? this.isSyncing,
      retryCount: retryCount ?? this.retryCount,
      lastSyncStatus: lastSyncStatus ?? this.lastSyncStatus,
    );
  }

  bool get hasPendingTransactions => totalPending > 0;
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
  bool get canSync => isConnected && !isSyncing;
  bool get isInitial => subState == SyncSubState.initial;
  bool get isOffline => subState == SyncSubState.offline;
  bool get isSuccess => subState == SyncSubState.success;
  bool get isFailure => subState == SyncSubState.failure;

  String get statusMessage {
    switch (subState) {
      case SyncSubState.initial:
        return 'Sincronización no iniciada';
      case SyncSubState.loading:
        return 'Cargando transacciones pendientes...';
      case SyncSubState.syncing:
        return 'Sincronizando $totalSynced de $totalPending transacciones...';
      case SyncSubState.success:
        return 'Sincronización completada. $totalSynced transacciones sincronizadas.';
      case SyncSubState.failure:
        return errorMessage ?? 'Error en la sincronización';
      case SyncSubState.offline:
        return 'Sin conexión. Las transacciones se almacenarán localmente.';
      case SyncSubState.paused:
        return 'Sincronización pausada';
    }
  }

  @override
  List<Object?> get props => [
        subState,
        pendingTransactions,
        syncedTransactions,
        totalPending,
        totalSynced,
        totalFailed,
        isConnected,
        errorMessage,
        lastSyncTime,
        progressPercentage,
        isSyncing,
        retryCount,
        lastSyncStatus,
      ];
}