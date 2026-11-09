package:payment_app.presentation.blocs.transaction;

import 'package:equatable/equatable.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class CreateTransactionEvent extends TransactionEvent {
  final String userId;
  final double amount;
  final String currency;
  final String recipientId;

  const CreateTransactionEvent({
    required this.userId,
    required this.amount,
    required this.currency,
    required this.recipientId,
  });

  @override
  List<Object?> get props => [userId, amount, currency, recipientId];
}

class LoadTransactionsEvent extends TransactionEvent {
  const LoadTransactionsEvent();
}

class LoadPendingTransactionsEvent extends TransactionEvent {
  const LoadPendingTransactionsEvent();
}

class RetryTransactionEvent extends TransactionEvent {
  final String transactionId;

  const RetryTransactionEvent({required this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}

class DeleteTransactionEvent extends TransactionEvent {
  final String transactionId;

  const DeleteTransactionEvent({required this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}

class RefreshTransactionsEvent extends TransactionEvent {
  const RefreshTransactionsEvent();
}