package payment_app.core.errors;

import 'package:equatable/equatable.dart';
import 'package:payment_app/domain/entities/entities.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;
  final DateTime timestamp;

  const Failure({
    required this.message,
    this.code,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  List<Object?> get props => [message, code, timestamp];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.timestamp,
  });

  factory ServerFailure.timeout() => const ServerFailure(
        message: 'La solicitud ha excedido el tiempo de espera',
        code: 408,
      );

  factory ServerFailure.unavailable() => const ServerFailure(
        message: 'El servidor no está disponible',
        code: 503,
      );

  factory ServerFailure.unauthorized() => const ServerFailure(
        message: 'No autorizado para realizar esta operación',
        code: 401,
      );

  factory ServerFailure.forbidden() => const ServerFailure(
        message: 'Acceso prohibido al recurso',
        code: 403,
      );

  factory ServerFailure.notFound() => const ServerFailure(
        message: 'Recurso no encontrado',
        code: 404,
      );

  factory ServerFailure.internalError([String? detail]) {
    final msg = detail != null ? 'Error interno del servidor: $detail' : 'Error interno del servidor';
    return ServerFailure(message: msg, code: 500);
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.timestamp,
  });

  factory NetworkFailure.noConnection() => const NetworkFailure(
        message: 'No hay conexión a Internet',
        code: -1,
      );

  factory NetworkFailure.connectionLost() => const NetworkFailure(
        message: 'Se perdió la conexión a Internet',
        code: -2,
      );

  factory NetworkFailure.timeout() => const NetworkFailure(
        message: 'Tiempo de espera de conexión agotado',
        code: -3,
      );

  factory NetworkFailure.unknown([String? detail]) {
    final msg = detail != null ? 'Error de red desconocido: $detail' : 'Error de red desconocido';
    return NetworkFailure(message: msg, code: -99);
  }
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
    super.timestamp,
  });

  factory CacheFailure.notFound() => const CacheFailure(
        message: 'Datos no encontrados en caché',
        code: 1001,
      );

  factory CacheFailure.readError() => const CacheFailure(
        message: 'Error al leer datos de caché',
        code: 1002,
      );

  factory CacheFailure.writeError() => const CacheFailure(
        message: 'Error al escribir datos en caché',
        code: 1003,
      );

  factory CacheFailure.deleteError() => const CacheFailure(
        message: 'Error al eliminar datos de caché',
        code: 1004,
      );

  factory CacheFailure.databaseCorrupted() => const CacheFailure(
        message: 'La base de datos local está corrupta',
        code: 1005,
      );

  factory CacheFailure.syncConflict() => const CacheFailure(
        message: 'Conflicto de sincronización detectado',
        code: 1006,
      );
}

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    super.timestamp,
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [message, code, timestamp, fieldErrors];

  factory ValidationFailure.invalidAmount() => const ValidationFailure(
        message: 'El monto de la transacción no es válido',
        code: 2001,
      );

  factory ValidationFailure.invalidCurrency() => const ValidationFailure(
        message: 'La moneda especificada no es válida',
        code: 2002,
      );

  factory ValidationFailure.missingRequiredField(String fieldName) =>
      ValidationFailure(
        message: 'El campo requerido \'$fieldName\' no está presente',
        code: 2003,
        fieldErrors: {fieldName: 'Campo requerido'},
      );

  factory ValidationFailure.invalidFormat(String fieldName) =>
      ValidationFailure(
        message: 'El formato del campo \'$fieldName\' es inválido',
        code: 2004,
        fieldErrors: {fieldName: 'Formato inválido'},
      );
}

class SyncFailure extends Failure {
  final int retryCount;
  final String? transactionId;

  const SyncFailure({
    required super.message,
    super.code,
    super.timestamp,
    this.retryCount = 0,
    this.transactionId,
  });

  @override
  List<Object?> get props =>
      [message, code, timestamp, retryCount, transactionId];

  factory SyncFailure.maxRetriesExceeded(String transactionId, int maxRetries) =>
      SyncFailure(
        message:
            'Se excedió el número máximo de reintentos ($maxRetries) para la transacción',
        code: 3001,
        retryCount: maxRetries,
        transactionId: transactionId,
      );

  factory SyncFailure.conflictDetected(String transactionId) => SyncFailure(
        message: 'Conflicto de sincronización detectado para transacción',
        code: 3002,
        transactionId: transactionId,
      );

  factory SyncFailure.serverRejected(String transactionId, String reason) =>
      SyncFailure(
        message: 'El servidor rechazó la transacción: $reason',
        code: 3003,
        transactionId: transactionId,
      );
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.code,
    super.timestamp,
  });

  factory UnknownFailure.unexpected([String? detail]) {
    final msg = detail != null ? 'Ocurrió un error inesperado: $detail' : 'Ocurrió un error inesperado';
    return UnknownFailure(message: msg, code: 9999);
  }
}