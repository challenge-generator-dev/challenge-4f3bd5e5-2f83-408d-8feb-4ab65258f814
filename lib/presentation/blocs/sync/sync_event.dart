import 'package:equatable/equatable.dart';
import 'package:payment_app/domain/entities/entities.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object?> get props => [];
}

class SyncStarted extends SyncEvent {
  const SyncStarted();
}

class SyncRequested extends SyncEvent {
  const SyncRequested();
}

class SyncCompleted extends SyncEvent {
  final List<TransactionEntity> syncedTransactions;

  const SyncCompleted({required this.syncedTransactions});

  @override
  List<Object?> get props => [syncedTransactions];
}

class SyncFailed extends SyncEvent {
  final String errorMessage;
  final int failedCount;

  const SyncFailed({
    required this.errorMessage,
    this.failedCount = 0,
  });

  @override
  List<Object?> get props => [errorMessage, failedCount];
}

class NetworkStatusChanged extends SyncEvent {
  final bool isConnected;

  const NetworkStatusChanged({required this.isConnected});

  @override
  List<Object?> get props => [isConnected];
}

class RetrySyncRequested extends SyncEvent {
  const RetrySyncRequested();
}

class PendingTransactionsLoaded extends SyncEvent {
  final List<TransactionEntity> pendingTransactions;

  const PendingTransactionsLoaded({required this.pendingTransactions});

  @override
  List<Object?> get props => [pendingTransactions];
}

class SchedulePeriodicSync extends SyncEvent {
  final Duration interval;

  const SchedulePeriodicSync({required this.interval});

  @override
  List<Object?> get props => [interval];
}

class CancelPeriodicSync extends SyncEvent {
  const CancelPeriodicSync();
}

class ForceFullSync extends SyncEvent {
  const ForceFullSync();
}

class SyncPaused extends SyncEvent {
  const SyncPaused();
}

class SyncResumed extends SyncEvent {
  const SyncResumed();
}