import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class GetPendingTransactionsUseCase {
  final TransactionRepository repository;

  GetPendingTransactionsUseCase(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call() async {
    return await repository.getPendingTransactions();
  }

  Future<Either<Failure, List<TransactionEntity>>> callByUserId(
      String userId) async {
    if (userId.isEmpty) {
      return const Left(ValidationFailure('El ID de usuario no puede estar vacío'));
    }

    final result = await repository.getPendingTransactions();

    return result.fold(
      (failure) => Left(failure),
      (transactions) {
        final filteredTransactions = transactions
            .where((t) => t.userId == userId)
            .toList();

        filteredTransactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return Right(filteredTransactions);
      },
    );
  }

  Future<Either<Failure, Map<SyncStatus, int>>> getPendingCountByStatus()
      async {
    final result = await repository.getPendingTransactions();

    return result.fold(
      (failure) => Left(failure),
      (transactions) {
        final counts = <SyncStatus, int>{};

        for (final status in SyncStatus.values) {
          counts[status] = transactions.where((t) => t.syncStatus == status).length;
        }

        return Right(counts);
      },
    );
  }
}

class ValidationFailure extends Failure {
  final String message;

  const ValidationFailure(this.message);

  @override
  String toString() => 'ValidationFailure: $message';
}