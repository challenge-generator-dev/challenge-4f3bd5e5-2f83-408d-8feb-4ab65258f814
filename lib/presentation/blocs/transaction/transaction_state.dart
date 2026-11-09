package:payment_app.presentation.blocs.transaction;

import 'package:equatable/equatable.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionLoading extends TransactionState {
  const TransactionLoading();
}

class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> transactions;
  final int pendingCount;
  final int failedCount;
  final double totalAmount;

  const TransactionLoaded({
    required this.transactions,
    this.pendingCount = 0,
    this.failedCount = 0,
    this.totalAmount = 0.0,
  });

  TransactionLoaded copyWith({
    List<TransactionEntity>? transactions,
    int? pendingCount,
    int? failedCount,
    double? totalAmount,
  }) {
    return TransactionLoaded(
      transactions: transactions ?? this.transactions,
      pendingCount: pendingCount ?? this.pendingCount,
      failedCount: failedCount ?? this.failedCount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [transactions, pendingCount, failedCount, totalAmount];
}

class TransactionCreated extends TransactionState {
  final TransactionEntity transaction;
  final bool isSynced;

  const TransactionCreated({
    required this.transaction,
    this.isSynced = false,
  });

  @override
  List<Object?> get props => [transaction, isSynced];
}

class TransactionDeleted extends TransactionState {
  final String transactionId;

  const TransactionDeleted({required this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}

class TransactionError extends TransactionState {
  final String message;
  final List<TransactionEntity>? cachedTransactions;

  const TransactionError({
    required this.message,
    this.cachedTransactions,
  });

  @override
  List<Object?> get props => [message, cachedTransactions];
}

class TransactionRetrying extends TransactionState {
  final String transactionId;
  final int retryCount;

  const TransactionRetrying({
    required this.transactionId,
    required this.retryCount,
  });

  @override
  List<Object?> get props => [transactionId, retryCount];
}