package:payment_app.presentation.blocs.transaction;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';
import 'package:payment_app/domain/usecases/create_transaction_usecase.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions_usecase.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app.core.errors.failures';
import 'package:payment_app.presentation.blocs.transaction.transaction_event.dart';
import 'package:payment_app.presentation.blocs.transaction.transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CreateTransactionUseCase createTransactionUseCase;
  final GetPendingTransactionsUseCase getPendingTransactionsUseCase;
  final TransactionRepository transactionRepository;
  final Uuid _uuid = const Uuid();

  TransactionBloc({
    required this.createTransactionUseCase,
    required this.getPendingTransactionsUseCase,
    required this.transactionRepository,
  }) : super(const TransactionInitial()) {
    on<CreateTransactionEvent>(_onCreateTransaction);
    on<LoadTransactionsEvent>(_onLoadTransactions);
    on<LoadPendingTransactionsEvent>(_onLoadPendingTransactions);
    on<RetryTransactionEvent>(_onRetryTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<RefreshTransactionsEvent>(_onRefreshTransactions);
  }

  Future<void> _onCreateTransaction(
    CreateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final transaction = TransactionEntity(
      id: _uuid.v4(),
      userId: event.userId,
      amount: event.amount,
      currency: event.currency,
      recipientId: event.recipientId,
      createdAt: DateTime.now(),
      syncStatus: SyncStatus.pending,
      retryCount: 0,
    );

    final result = await createTransactionUseCase(transaction);

    result.fold(
      (failure) => emit(TransactionError(
        message: _mapFailureToMessage(failure),
      )),
      (createdTransaction) => emit(TransactionCreated(
        transaction: createdTransaction,
        isSynced: createdTransaction.syncStatus == SyncStatus.synced,
      )),
    );
  }

  Future<void> _onLoadTransactions(
    LoadTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final result = await transactionRepository.getAllTransactions();

    result.fold(
      (failure) => emit(TransactionError(
        message: _mapFailureToMessage(failure),
      )),
      (transactions) {
        final pendingCount = transactions
            .where((t) => t.syncStatus == SyncStatus.pending)
            .length;
        final failedCount = transactions
            .where((t) => t.syncStatus == SyncStatus.failed)
            .length;
        final totalAmount = transactions
            .where((t) => t.syncStatus == SyncStatus.synced)
            .fold(0.0, (sum, t) => sum + t.amount);

        emit(TransactionLoaded(
          transactions: transactions,
          pendingCount: pendingCount,
          failedCount: failedCount,
          totalAmount: totalAmount,
        ));
      },
    );
  }

  Future<void> _onLoadPendingTransactions(
    LoadPendingTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final result = await getPendingTransactionsUseCase();

    result.fold(
      (failure) => emit(TransactionError(
        message: _mapFailureToMessage(failure),
      )),
      (transactions) {
        final pendingCount = transactions
            .where((t) => t.syncStatus == SyncStatus.pending)
            .length;
        final failedCount = transactions
            .where((t) => t.syncStatus == SyncStatus.failed)
            .length;
        final totalAmount = transactions
            .fold(0.0, (sum, t) => sum + t.amount);

        emit(TransactionLoaded(
          transactions: transactions,
          pendingCount: pendingCount,
          failedCount: failedCount,
          totalAmount: totalAmount,
        ));
      },
    );
  }

  Future<void> _onRetryTransaction(
    RetryTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final currentState = state;
    if (currentState is TransactionLoaded) {
      final transactionToRetry = currentState.transactions
          .firstWhere(
            (t) => t.id == event.transactionId,
            orElse: () => throw Exception('Transaction not found'),
          );

      emit(TransactionRetrying(
        transactionId: event.transactionId,
        retryCount: transactionToRetry.retryCount + 1,
      ));

      final updatedTransaction = transactionToRetry.copyWith(
        syncStatus: SyncStatus.pending,
        retryCount: transactionToRetry.retryCount + 1,
        errorMessage: null,
      );

      final result = await transactionRepository.updateTransaction(updatedTransaction);

      result.fold(
        (failure) => emit(TransactionError(
          message: _mapFailureToMessage(failure),
          cachedTransactions: currentState.transactions,
        )),
        (_) => add(const LoadTransactionsEvent()),
      );
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final currentState = state;
    emit(const TransactionLoading());

    final result = await transactionRepository.deleteTransaction(event.transactionId);

    result.fold(
      (failure) => emit(TransactionError(
        message: _mapFailureToMessage(failure),
        cachedTransactions: currentState is TransactionLoaded
            ? currentState.transactions
            : null,
      )),
      (_) => emit(TransactionDeleted(transactionId: event.transactionId)),
    );
  }

  Future<void> _onRefreshTransactions(
    RefreshTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    add(const LoadTransactionsEvent());
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Error del servidor: ${failure.message}';
    } else if (failure is CacheFailure) {
      return 'Error de almacenamiento local: ${failure.message}';
    } else if (failure is NetworkFailure) {
      return 'Sin conexión a internet. La transacción se guardará localmente.';
    }
    return 'Error desconocido';
  }
}