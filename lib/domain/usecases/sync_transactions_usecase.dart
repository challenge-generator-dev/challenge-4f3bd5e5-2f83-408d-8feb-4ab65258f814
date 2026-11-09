import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class SyncTransactionsUseCase {
  final TransactionRepository repository;

  static const int maxRetryCount = 3;
  static const int retryDelaySeconds = 5;

  SyncTransactionsUseCase(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call() async {
    return await repository.syncTransactions();
  }

  Future<Either<Failure, SyncResult>> callWithRetryPolicy() async {
    final result = await repository.getPendingTransactions();

    return result.fold(
      (failure) => Left(failure),
      (pendingTransactions) async {
        if (pendingTransactions.isEmpty) {
          return const Right(SyncResult(
            syncedCount: 0,
            failedCount: 0,
            totalCount: 0,
          ));
        }

        final toRetry = pendingTransactions
            .where((t) =>
                t.syncStatus == SyncStatus.failed &&
                t.retryCount < maxRetryCount)
            .toList();

        final toSync = pendingTransactions
            .where((t) => t.syncStatus == SyncStatus.pending)
            .toList();

        final allToSync = [...toSync, ...toRetry];
        var syncedCount = 0;
        var failedCount = 0;

        for (final transaction in allToSync) {
          final syncResult = await _syncSingleTransaction(transaction);

          syncResult.fold(
            (failure) => failedCount++,
            (synced) => syncedCount++,
          );
        }

        return Right(SyncResult(
          syncedCount: syncedCount,
          failedCount: failedCount,
          totalCount: allToSync.length,
        ));
      },
    );
  }

  Future<Either<Failure, TransactionEntity>> _syncSingleTransaction(
      TransactionEntity transaction) async {
    final result = await repository.syncTransactions();

    return result.fold(
      (failure) => Left(failure),
      (syncedTransactions) {
        final synced = syncedTransactions.firstWhere(
          (t) => t.id == transaction.id,
          orElse: () => transaction,
        );

        if (synced.syncStatus == SyncStatus.synced) {
          return Right(synced);
        } else {
          return Left(SyncFailure(
            'Error al sincronizar la transacción ${transaction.id}: ${synced.errorMessage ?? "Error desconocido"}',
          ));
        }
      },
    );
  }

  Future<Either<Failure, List<TransactionEntity>>>
      syncTransactionsByUserId(String userId) async {
    if (userId.isEmpty) {
      return const Left(ValidationFailure('El ID de usuario no puede estar vacío'));
    }

    final pendingResult = await repository.getPendingTransactions();

    return pendingResult.fold(
      (failure) => Left(failure),
      (pendingTransactions) async {
        final userTransactions = pendingTransactions
            .where((t) => t.userId == userId)
            .toList();

        if (userTransactions.isEmpty) {
          return const Right([]);
        }

        final allResults = <TransactionEntity>[];

        for (final transaction in userTransactions) {
          final updatedTransaction = transaction.copyWith(
            syncStatus: SyncStatus.syncing,
            updatedAt: DateTime.now(),
          );

          final updateResult = await repository.updateTransaction(updatedTransaction);

          await Future.delayed(const Duration(milliseconds: 100));

          allResults.add(updatedTransaction);
        }

        return Right(allResults);
      },
    );
  }
}

class SyncResult {
  final int syncedCount;
  final int failedCount;
  final int totalCount;

  const SyncResult({
    required this.syncedCount,
    required this.failedCount,
    required this.totalCount,
  });

  double get successRate =>
      totalCount > 0 ? (syncedCount / totalCount) * 100 : 0;

  bool get hasFailures => failedCount > 0;

  @override
  String toString() =>
      'SyncResult(synced: $syncedCount, failed: $failedCount, total: $totalCount, successRate: ${successRate.toStringAsFixed(1)}%)';
}

class SyncFailure extends Failure {
  final String message;

  const SyncFailure(this.message);

  @override
  String toString() => 'SyncFailure: $message';
}

class ValidationFailure extends Failure {
  final String message;

  const ValidationFailure(this.message);

  @override
  String toString() => 'ValidationFailure: $message';
}