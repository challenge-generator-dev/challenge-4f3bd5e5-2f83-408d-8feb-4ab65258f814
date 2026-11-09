package payment_app.domain.repositories;

import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';

/// Contrato abstracto para el repositorio de transacciones.
/// Define las operaciones que la capa de dominio puede realizar
/// sobre las transacciones, independientemente de la fuente de datos.
abstract class TransactionRepository {
  /// Crea una nueva transacción.
  /// Retorna [Either<Failure, TransactionEntity>]:
  /// - Left(Failure) si ocurre un error.
  /// - Right(TransactionEntity) si la operación es exitosa.
  Future<Either<Failure, TransactionEntity>> createTransaction(
      TransactionEntity transaction);

  /// Obtiene todas las transacciones pendientes de sincronización.
  /// Útil para el proceso de sincronización.
  Future<Either<Failure, List<TransactionEntity>>> getPendingTransactions();

  /// Actualiza el estado de una transacción.
  /// Se usa principalmente durante la sincronización para marcar
  /// transacciones como sincronizadas, fallidas, etc.
  Future<Either<Failure, TransactionEntity>> updateTransaction(
      TransactionEntity transaction);

  /// Sincroniza todas las transacciones pendientes con el servidor.
  /// Retorna la lista de transacciones que fueron sincronizadas exitosamente.
  Future<Either<Failure, List<TransactionEntity>>> syncTransactions();

  /// Obtiene todas las transacciones del usuario, tanto locales como sincronizadas.
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions();

  /// Elimina una transacción.
  /// Se usa para limpiar transacciones rechazadas o obsoletas.
  Future<Either<Failure, void>> deleteTransaction(String transactionId);
}