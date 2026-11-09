import 'package:flutter_test/flutter_test.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';

void main() {
  group('TransactionEntity', () {
    final testTransaction = TransactionEntity(
      id: 'txn-123',
      userId: 'user-456',
      amount: 100.50,
      currency: 'USD',
      recipientId: 'recipient-789',
      createdAt: DateTime(2024, 1, 15, 10, 30),
      updatedAt: DateTime(2024, 1, 15, 10, 30),
      syncStatus: SyncStatus.pending,
      retryCount: 0,
      serverId: null,
      errorMessage: null,
    );

    test('debería crear una transacción con todos los campos correctamente', () {
      expect(testTransaction.id, 'txn-123');
      expect(testTransaction.userId, 'user-456');
      expect(testTransaction.amount, 100.50);
      expect(testTransaction.currency, 'USD');
      expect(testTransaction.recipientId, 'recipient-789');
      expect(testTransaction.createdAt, DateTime(2024, 1, 15, 10, 30));
      expect(testTransaction.syncStatus, SyncStatus.pending);
      expect(testTransaction.retryCount, 0);
      expect(testTransaction.serverId, isNull);
      expect(testTransaction.errorMessage, isNull);
    });

    test('debería convertir a JSON correctamente', () {
      final json = testTransaction.toJson();

      expect(json['id'], 'txn-123');
      expect(json['userId'], 'user-456');
      expect(json['amount'], 100.50);
      expect(json['currency'], 'USD');
      expect(json['recipientId'], 'recipient-789');
      expect(json['createdAt'], testTransaction.createdAt.toIso8601String());
      expect(json['syncStatus'], 'pending');
      expect(json['retryCount'], 0);
    });

    test('debería crear una transacción desde JSON correctamente', () {
      final json = {
        'id': 'txn-456',
        'userId': 'user-789',
        'amount': 250.75,
        'currency': 'EUR',
        'recipientId': 'recipient-012',
        'createdAt': '2024-02-20T14:45:00.000',
        'updatedAt': '2024-02-20T14:45:00.000',
        'syncStatus': 'synced',
        'retryCount': 2,
        'serverId': 'server-001',
        'errorMessage': null,
      };

      final entity = TransactionEntity.fromJson(json);

      expect(entity.id, 'txn-456');
      expect(entity.userId, 'user-789');
      expect(entity.amount, 250.75);
      expect(entity.currency, 'EUR');
      expect(entity.recipientId, 'recipient-012');
      expect(entity.syncStatus, SyncStatus.synced);
      expect(entity.retryCount, 2);
      expect(entity.serverId, 'server-001');
    });

    test('debería manejar valores nulos en JSON correctamente', () {
      final json = {
        'id': 'txn-999',
        'userId': 'user-111',
        'amount': 50.0,
        'currency': 'GBP',
        'recipientId': 'recipient-222',
        'createdAt': '2024-03-10T08:00:00.000',
        'updatedAt': null,
        'syncStatus': 'pending',
        'retryCount': 0,
        'serverId': null,
        'errorMessage': 'Error de conexión',
      };

      final entity = TransactionEntity.fromJson(json);

      expect(entity.updatedAt, isNull);
      expect(entity.serverId, isNull);
      expect(entity.errorMessage, 'Error de conexión');
    });

    test('copyWith debería actualizar solo los campos especificados', () {
      final updated = testTransaction.copyWith(
        syncStatus: SyncStatus.synced,
        serverId: 'server-abc',
        retryCount: 1,
      );

      expect(updated.id, testTransaction.id);
      expect(updated.userId, testTransaction.userId);
      expect(updated.amount, testTransaction.amount);
      expect(updated.currency, testTransaction.currency);
      expect(updated.recipientId, testTransaction.recipientId);
      expect(updated.createdAt, testTransaction.createdAt);
      expect(updated.syncStatus, SyncStatus.synced);
      expect(updated.serverId, 'server-abc');
      expect(updated.retryCount, 1);
    });

    test('copyWith debería mantener todos los valores cuando no se especifica nada', () {
      final copied = testTransaction.copyWith();

      expect(copied.id, testTransaction.id);
      expect(copied.userId, testTransaction.userId);
      expect(copied.amount, testTransaction.amount);
      expect(copied.currency, testTransaction.currency);
      expect(copied.recipientId, testTransaction.recipientId);
      expect(copied.syncStatus, testTransaction.syncStatus);
    });

    test('dos transacciones con los mismos valores deberían ser iguales', () {
      final transaction1 = TransactionEntity(
        id: 'txn-same',
        userId: 'user-same',
        amount: 100.0,
        currency: 'USD',
        recipientId: 'recipient-same',
        createdAt: DateTime(2024, 1, 1),
        syncStatus: SyncStatus.pending,
        retryCount: 0,
      );

      final transaction2 = TransactionEntity(
        id: 'txn-same',
        userId: 'user-same',
        amount: 100.0,
        currency: 'USD',
        recipientId: 'recipient-same',
        createdAt: DateTime(2024, 1, 1),
        syncStatus: SyncStatus.pending,
        retryCount: 0,
      );

      expect(transaction1, equals(transaction2));
    });

    test('debería convertir todos los estados de sincronización a string correctamente', () {
      final pendingJson = testTransaction.copyWith(syncStatus: SyncStatus.pending).toJson();
      final syncedJson = testTransaction.copyWith(syncStatus: SyncStatus.synced).toJson();
      final failedJson = testTransaction.copyWith(syncStatus: SyncStatus.failed).toJson();
      final syncingJson = testTransaction.copyWith(syncStatus: SyncStatus.syncing).toJson();

      expect(pendingJson['syncStatus'], 'pending');
      expect(syncedJson['syncStatus'], 'synced');
      expect(failedJson['syncStatus'], 'failed');
      expect(syncingJson['syncStatus'], 'syncing');
    });

    test('debería manejar valores monetary grandes correctamente', () {
      final largeAmount = TransactionEntity(
        id: 'txn-large',
        userId: 'user-large',
        amount: 999999999.99,
        currency: 'USD',
        recipientId: 'recipient-large',
        createdAt: DateTime.now(),
        syncStatus: SyncStatus.pending,
        retryCount: 0,
      );

      final json = largeAmount.toJson();
      final restored = TransactionEntity.fromJson(json);

      expect(restored.amount, 999999999.99);
    });

    test('debería manejar diferentes currencies correctamente', () {
      final currencies = ['USD', 'EUR', 'GBP', 'JPY', 'COP'];

      for (final currency in currencies) {
        final transaction = testTransaction.copyWith(
          id: 'txn-$currency',
          currency: currency,
        );

        final json = transaction.toJson();
        final restored = TransactionEntity.fromJson(json);

        expect(restored.currency, currency);
      }
    });

    test('debería incrementar retryCount correctamente', () {
      final withRetries = testTransaction.copyWith(
        retryCount: testTransaction.retryCount + 1,
      );

      expect(withRetries.retryCount, 1);

      final withMoreRetries = withRetries.copyWith(
        retryCount: withRetries.retryCount + 1,
      );

      expect(withMoreRetries.retryCount, 2);
    });

    test('debería actualizar errorMessage correctamente', () {
      final withError = testTransaction.copyWith(
        errorMessage: 'Timeout al conectar con el servidor',
        syncStatus: SyncStatus.failed,
      );

      expect(withError.errorMessage, 'Timeout al conectar con el servidor');
      expect(withError.syncStatus, SyncStatus.failed);

      final clearedError = withError.copyWith(
        errorMessage: null,
        syncStatus: SyncStatus.pending,
      );

      expect(clearedError.errorMessage, isNull);
      expect(clearedError.syncStatus, SyncStatus.pending);
    });
  });
}