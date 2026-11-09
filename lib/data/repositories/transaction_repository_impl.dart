import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/network/network_info.dart';
import 'package:payment_app/data/datasources/local/transaction_local_datasource.dart';
import 'package:payment_app/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;
  final TransactionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TransactionRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TransactionEntity>> createTransaction(
      TransactionEntity transaction) async {
    // Superficie de práctica - el estudiante debe implementar la lógica de fallback offline
    // Hint: Verificar conectividad, guardar localmente si no hay conexión, sincronizar después
    return const Left(NotImplementedFailure(message: 'Implementar en fase 2'));
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getPendingTransactions() async {
    // Superficie de práctica - el estudiante debe implementar la lógica de fallback offline
    return const Left(NotImplementedFailure(message: 'Implementar en fase 2'));
  }

  @override
  Future<Either<Failure, TransactionEntity>> updateTransaction(
      TransactionEntity transaction) async {
    // Superficie de práctica - el estudiante debe implementar la lógica de fallback offline
    return const Left(NotImplementedFailure(message: 'Implementar en fase 2'));
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> syncTransactions() async {
    // Superficie de práctica - el estudiante debe implementar la lógica de sincronización
    return const Left(NotImplementedFailure(message: 'Implementar en fase 3'));
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions() async {
    // Superficie de práctica - el estudiante debe implementar la lógica de fallback offline
    return const Left(NotImplementedFailure(message: 'Implementar en fase 2'));
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String transactionId) async {
    // Superficie de práctica - el estudiante debe implementar la lógica de fallback offline
    return const Left(NotImplementedFailure(message: 'Implementar en fase 2'));
  }
}

class NotImplementedFailure extends Failure {
  const NotImplementedFailure({required String message}) : super(message: message);
}

/// === ARCHIVO: lib/core/network/connectivity_service.dart ===
package payment_app.core.network;

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:payment_app/core/network/network_info.dart';

class ConnectivityService implements NetworkInfo {
  final Connectivity _connectivity;
  final StreamController<bool> _connectionStatusController;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isConnected = false;

  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity(),
        _connectionStatusController = StreamController<bool>.broadcast();

  Stream<bool> get connectionStatusStream =>
      _connectionStatusController.stream;

  bool get isConnected => _isConnected;

  Future<void> initialize() async {
    await _checkConnectionStatus();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _handleConnectivityChange,
      onError: (error) {
        _isConnected = false;
        _connectionStatusController.add(false);
      },
    );
  }

  Future<void> _checkConnectionStatus() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      _isConnected = false;
      _connectionStatusController.add(false);
    }
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final wasConnected = _isConnected;
    _isConnected = _hasActiveConnection(results);

    if (wasConnected != _isConnected) {
      _connectionStatusController.add(_isConnected);
    }
  }

  bool _hasActiveConnection(List<ConnectivityResult> results) {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return false;
    }
    return results.any((result) => result != ConnectivityResult.none);
  }

  @override
  Future<bool> get isConnected async {
    try {
      final result = await _connectivity.checkConnectivity();
      return _hasActiveConnection(result);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> get isConnectedWifi async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result.contains(ConnectivityResult.wifi);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> get isConnectedMobile async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result.contains(ConnectivityResult.mobile);
    } catch (e) {
      return false;
    }
  }

  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    await _connectionStatusController.close();
  }
}

/// === ARCHIVO: lib/core/network/network_info.dart ===
package payment_app.core.network;

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<bool> get isConnectedWifi;
  Future<bool> get isConnectedMobile;
}

/// === ARCHIVO: lib/core/errors/failures.dart ===
package payment_app.core.errors;

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;
  final DateTime timestamp;

  const Failure({
    required this.message,
    this.code,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? const _DefaultDateTime();

  @override
  List<Object?> get props => [message, code, timestamp];
}

class _DefaultDateTime implements DateTime {
  const _DefaultDateTime();

  @override
  DateTime add(Duration duration) => DateTime.now().add(duration);

  @override
  DateTime subtract(Duration duration) =>
      DateTime.now().subtract(duration);

  @override
  int compareTo(DateTime other) => DateTime.now().compareTo(other);

  @override
  Duration difference(DateTime other) =>
      DateTime.now().difference(other);

  @override
  bool isAfter(DateTime other) => DateTime.now().isAfter(other);

  @override
  bool isAtSameMomentAs(DateTime other) =>
      DateTime.now().isAtSameMomentAs(other);

  @override
  bool isBefore(DateTime other) => DateTime.now().isBefore(other);

  @override
  bool get isUtc => DateTime.now().isUtc;

  @override
  int get millisecondsSinceEpoch =>
      DateTime.now().millisecondsSinceEpoch;

  @override
  int get microsecondsSinceEpoch =>
      DateTime.now().microsecondsSinceEpoch;

  @override
  String toIso8601String() => DateTime.now().toIso8601String();

  @override
  DateTime toLocal() => DateTime.now().toLocal();

  @override
  DateTime toUtc() => DateTime.now().toUtc();

  @override
  int get day => DateTime.now().day;

  @override
  int get hour => DateTime.now().hour;

  @override
  int get microsecond => DateTime.now().microsecond;

  @override
  int get millisecond => DateTime.now().millisecond;

  @override
  int get minute => DateTime.now().minute;

  @override
  int get month => DateTime.now().month;

  @override
  int get second => DateTime.now().second;

  @override
  String get timeZoneName => DateTime.now().timeZoneName;

  @override
  Duration get timeZoneOffset => DateTime.now().timeZoneOffset;

  @override
  int get weekday => DateTime.now().weekday;

  @override
  int get year => DateTime.now().year;

  @override
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    bool? isUtc,
  }) =>
      DateTime.now().copyWith(
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
        isUtc: isUtc,
      );
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.timestamp,
  });

  factory ServerFailure.timeout() => const ServerFailure(
        message: 'La conexión con el servidor ha expirado',
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

  factory ServerFailure.internalError([String? detail]) => ServerFailure(
        message: detail ?? 'Error interno del servidor',
        code: 500,
      );
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.timestamp,
  });

  factory NetworkFailure.noConnection() => const NetworkFailure(
        message: 'No hay conexión a internet',
        code: 0,
      );

  factory NetworkFailure.connectionLost() => const NetworkFailure(
        message: 'Se perdió la conexión a internet',
        code: 0,
      );

  factory NetworkFailure.timeout() => const NetworkFailure(
        message: 'Tiempo de conexión agotado',
        code: 408,
      );

  factory NetworkFailure.unknown([String? detail]) => NetworkFailure(
        message: detail ?? 'Error de red desconocido',
        code: -1,
      );
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
    super.timestamp,
  });

  factory CacheFailure.notFound() => const CacheFailure(
        message: 'Datos no encontrados en caché local',
        code: 404,
      );

  factory CacheFailure.readError() => const CacheFailure(
        message: 'Error al leer datos del almacenamiento local',
        code: 500,
      );

  factory CacheFailure.writeError() => const CacheFailure(
        message: 'Error al guardar datos en almacenamiento local',
        code: 500,
      );

  factory CacheFailure.deleteError() => const CacheFailure(
        message: 'Error al eliminar datos del almacenamiento local',
        code: 500,
      );

  factory CacheFailure.databaseCorrupted() => const CacheFailure(
        message: 'La base de datos local está corrupta',
        code: 500,
      );

  factory CacheFailure.syncConflict() => const CacheFailure(
        message: 'Conflicto de sincronización detectado',
        code: 409,
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
        message: 'El monto especificado es inválido',
        code: 400,
      );

  factory ValidationFailure.invalidCurrency() => const ValidationFailure(
        message: 'La moneda especificada no es válida',
        code: 400,
      );

  factory ValidationFailure.missingRequiredField(String fieldName) =>
      ValidationFailure(
        message: 'El campo $fieldName es requerido',
        code: 400,
        fieldErrors: {fieldName: 'required'},
      );

  factory ValidationFailure.invalidFormat(String fieldName) =>
      ValidationFailure(
        message: 'El formato del campo $fieldName es inválido',
        code: 400,
        fieldErrors: {fieldName: 'invalid_format'},
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
  List<Object?> get props => [message, code, timestamp, retryCount, transactionId];

  factory SyncFailure.maxRetriesExceeded(String transactionId, int maxRetries) =>
      SyncFailure(
        message: 'Se superó el número máximo de intentos de sincronización',
        code: 500,
        retryCount: maxRetries,
        transactionId: transactionId,
      );

  factory SyncFailure.conflictDetected(String transactionId) => SyncFailure(
        message: 'Conflicto de datos detectado durante sincronización',
        code: 409,
        transactionId: transactionId,
      );

  factory SyncFailure.serverRejected(String transactionId, String reason) =>
      SyncFailure(
        message: 'El servidor rechazó la transacción: $reason',
        code: 422,
        transactionId: transactionId,
      );
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.code,
    super.timestamp,
  });

  factory UnknownFailure.unexpected([String? detail]) => UnknownFailure(
        message: detail ?? 'Ocurrió un error inesperado',
        code: -1,
      );
}