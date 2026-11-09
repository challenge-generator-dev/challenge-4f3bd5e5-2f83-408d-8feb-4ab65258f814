import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';

abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

class ServerException extends AppException {
  final int? statusCode;
  final String? endpoint;

  const ServerException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.statusCode,
    this.endpoint,
  });

  @override
  String toString() =>
      'ServerException: $message [status: $statusCode, endpoint: $endpoint]';
}

class CacheException extends AppException {
  final String? tableName;
  final String? operation;

  const CacheException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.tableName,
    this.operation,
  });

  @override
  String toString() =>
      'CacheException: $message [table: $tableName, operation: $operation]';
}

class NetworkException extends AppException {
  final bool isConnected;
  final String? connectionType;

  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.isConnected = false,
    this.connectionType,
  });

  @override
  String toString() =>
      'NetworkException: $message [connected: $isConnected, type: $connectionType]';
}

class SyncException extends AppException {
  final SyncStatus? failedStatus;
  final int retryCount;
  final int maxRetries;
  final String? transactionId;

  const SyncException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.failedStatus,
    this.retryCount = 0,
    this.maxRetries = 3,
    this.transactionId,
  });

  bool get canRetry => retryCount < maxRetries;

  @override
  String toString() =>
      'SyncException: $message [transactionId: $transactionId, retry: $retryCount/$maxRetries]';
}

class ValidationException extends AppException {
  final Map<String, List<String>>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.fieldErrors,
  });

  @override
  String toString() => 'ValidationException: $message [fields: $fieldErrors]';
}

class DatabaseException extends AppException {
  final int? errorCode;
  final String? sqlStatement;

  const DatabaseException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.errorCode,
    this.sqlStatement,
  });

  @override
  String toString() =>
      'DatabaseException: $message [code: $errorCode, sql: $sqlStatement]';
}

class AuthenticationException extends AppException {
  final String? token;
  final DateTime? expiredAt;

  const AuthenticationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.token,
    this.expiredAt,
  });

  @override
  String toString() =>
      'AuthenticationException: $message [expired: $expiredAt]';
}

class TimeoutException extends AppException {
  final Duration? timeout;
  final String? operation;

  const TimeoutException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.timeout,
    this.operation,
  });

  @override
  String toString() =>
      'TimeoutException: $message [duration: ${timeout?.inSeconds}s, operation: $operation]';
}

class ConflictException extends AppException {
  final String? serverVersion;
  final String? localVersion;
  final String? entityId;

  const ConflictException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.serverVersion,
    this.localVersion,
    this.entityId,
  });

  @override
  String toString() =>
      'ConflictException: $message [entityId: $entityId, local: $localVersion, server: $serverVersion]';
}