package payment_app.domain.usecases;

import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/entities.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class CreateTransactionUseCase {
  final TransactionRepository repository;

  CreateTransactionUseCase(this.repository);

  Future<Either<Failure, TransactionEntity>> call({
    required String userId,
    required double amount,
    required String currency,
    required String recipientId,
  }) async {
    if (userId.isEmpty) {
      return const Left(ValidationFailure(
        message: 'El ID de usuario no puede estar vacío',
        code: 2003,
      ));
    }

    if (amount <= 0) {
      return const Left(ValidationFailure(
        message: 'El monto debe ser mayor a cero',
        code: 2001,
      ));
    }

    if (currency.isEmpty) {
      return const Left(ValidationFailure(
        message: 'La moneda no puede estar vacía',
        code: 2003,
      ));
    }

    if (recipientId.isEmpty) {
      return const Left(ValidationFailure(
        message: 'El ID del destinatario no puede estar vacío',
        code: 2003,
      ));
    }

    const supportedCurrencies = ['USD', 'EUR', 'MXN', 'COP', 'BRL'];
    if (!supportedCurrencies.contains(currency.toUpperCase())) {
      final supportedList = supportedCurrencies.join(', ');
      return Left(ValidationFailure(
        message: 'Moneda no soportada. Las monedas soportadas son: $supportedList',
        code: 2002,
      ));
    }

    final transaction = TransactionEntity(
      id: '',
      userId: userId,
      amount: amount,
      currency: currency.toUpperCase(),
      recipientId: recipientId,
      createdAt: DateTime.now(),
      updatedAt: null,
      syncStatus: SyncStatus.pending,
      retryCount: 0,
      serverId: null,
      errorMessage: null,
    );

    return await repository.createTransaction(transaction);
  }
}