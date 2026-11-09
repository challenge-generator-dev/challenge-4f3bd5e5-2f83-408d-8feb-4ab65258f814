import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/data/datasources/local/transaction_local_datasource.dart';
import 'package:payment_app/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:payment_app/data/repositories/transaction_repository_impl.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';

class MockLocalDataSource extends Mock implements TransactionLocalDataSource {}

class MockRemoteDataSource extends Mock implements TransactionRemoteDataSource {}

void main() {
  late TransactionRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;

  final testTransaction = TransactionEntity(
    id: 'txn-test-123',
    userId: 'user-456',
    amount: 150.75,
    currency: 'USD',
    recipientId: 'recipient-789',
    createdAt: DateTime(2024, 1, 20, 12, 0),
    updatedAt: DateTime(2024, 1, 20, 12, 0),
    syncStatus: SyncStatus.pending,
    retryCount: 0,
    serverId: null,
    errorMessage: null,
  );

  final testTransactionList = [
    testTransaction,
    testTransaction.copyWith(
      id: 'txn-test-456',
      amount: 200.00,
      syncStatus: SyncStatus.synced,
      serverId: 'server-001',
    ),
  ];

  setUpAll(() {
    registerFallbackValue(testTransaction);
  });

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    repository = TransactionRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('createTransaction', () {
    test('debería guardar la transacción localmente y retornarla', () async {
      when(() => mockLocalDataSource.createTransaction(any()))
          .thenAnswer((_) async => testTransaction);

      final result = await repository.createTransaction(testTransaction);

      expect(result, isA<Right<Failure, TransactionEntity>>());
      result.fold(
        (failure) => fail('No debería retornar failure'),
        (entity) {
          expect(entity.id, testTransaction.id);
          expect(entity.amount, testTransaction.amount);
        },
      );
      verify(() => mockLocalDataSource.createTransaction(testTransaction)).called(1);
    });

    test('debería retornar DatabaseFailure cuando falla el almacenamiento local', () async {
      when(() => mockLocalDataSource.createTransaction(any()))
          .thenThrow(LocalDatabaseException('Error de base de datos'));

      final result = await repository.createTransaction(testTransaction);

      expect(result, isA<Left<Failure, TransactionEntity>>());
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect(failure.message, contains('Error de base de datos'));
        },
        (_) => fail('No debería retornar entidad'),
      );
    });
  });

  group('getPendingTransactions', () {
    test('debería retornar todas las transacciones pendientes del almacenamiento local', () async {
      when(() => mockLocalDataSource.getPendingTransactions())
          .thenAnswer((_) async => testTransactionList);

      final result = await repository.getPendingTransactions();

      expect(result, isA<Right<Failure, List<TransactionEntity>>>());
      result.fold(
        (failure) => fail('No debería retornar failure'),
        (entities) {
          expect(entities.length, 2);
          expect(entities.every((e) => e.syncStatus == SyncStatus.pending || e.syncStatus == SyncStatus.synced), isTrue);
        },
      );
      verify(() => mockLocalDataSource.getPendingTransactions()).called(1);
    });

    test('debería retornar DatabaseFailure cuando falla la consulta', () async {
      when(() => mockLocalDataSource.getPendingTransactions())
          .thenThrow(LocalDatabaseException('Consulta fallida'));

      final result = await repository.getPendingTransactions();

      expect(result, isA<Left<Failure, List<TransactionEntity>>>());
      result.fold(
        (failure) => expect(failure, isA<DatabaseFailure>()),
        (_) => fail('No debería retornar lista'),
      );
    });

    test('debería retornar lista vacía cuando no hay transacciones pendientes', () async {
      when(() => mockLocalDataSource.getPendingTransactions())
          .thenAnswer((_) async => []);

      final result = await repository.getPendingTransactions();

      result.fold(
        (failure) => fail('No debería retornar failure'),
        (entities) => expect(entities, isEmpty),
      );
    });
  });

  group('updateTransaction', () {
    test('debería actualizar la transacción en el almacenamiento local', () async {
      final updatedTransaction = testTransaction.copyWith(
        syncStatus: SyncStatus.synced,
        serverId: 'server-999',
      );

      when(() => mockLocalDataSource.updateTransaction(any()))
          .thenAnswer((_) async => updatedTransaction);

      final result = await repository.updateTransaction(updatedTransaction);

      expect(result, isA<Right<Failure, TransactionEntity>>());
      result.fold(
        (failure) => fail('No debería retornar failure'),
        (entity) {
          expect(entity.syncStatus, SyncStatus.synced);
          expect(entity.serverId, 'server-999');
        },
      );
      verify(() => mockLocalDataSource.updateTransaction(updatedTransaction)).called(1);
    });

    test('debería manejar error al actualizar transacción inexistente', () async {
      when(() => mockLocalDataSource.updateTransaction(any()))
          .thenThrow(LocalDatabaseException('Transacción no encontrada'));

      final result = await repository.updateTransaction(testTransaction);

      expect(result, isA<Left<Failure, TransactionEntity>>());
    });
  });

  group('syncTransactions', () {
    test('debería sincronizar transacciones pendientes con el servidor', () async {
      when(() => mockLocalDataSource.getPendingTransactions())
          .thenAnswer((_) async => [testTransaction]);
      when(() => mockRemoteDataSource.syncTransaction(any()))
          .thenAnswer((_) async => testTransaction.copyWith(
                serverId: 'server-synced-001',
                syncStatus: SyncStatus.synced,
              ));
      when(() => mockLocalDataSource.updateTransaction(any()))
          .thenAnswer((_) async => testTransaction.copyWith(
                serverId: 'server-synced-001',
                syncStatus: SyncStatus.synced,
              ));

      final result = await repository.syncTransactions();

      expect(result, isA<Right<Failure, List<TransactionEntity>>>());
      result.fold(
        (failure) => fail('No debería retornar failure'),
        (entities) {
          expect(entities.length, 1);
          expect(entities.first.syncStatus, SyncStatus.synced);
        },
      );
      verify(() => mockRemoteDataSource.syncTransaction(any())).called(1);
    });

    test('debería manejar error de red durante sincronización', () async {
      when(() => mockLocalDataSource.getPendingTransactions())
          .thenAnswer((_) async => [testTransaction]);
      when(() => mockRemoteDataSource.syncTransaction(any()))
          .thenThrow(NetworkException('Sin conexión'));

      final result = await repository.syncTransactions();

      expect(result, isA<Left<Failure, List<TransactionEntity>>>());
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, contains('Sin conexión'));
        },
        (_) => fail('No debería retornar lista'),
      );
    });

    test('debería actualizar el estado a failed cuando el servidor rechaza la transacción', () async {
      when(() => mockLocalDataSource.getPendingTransactions())
          .thenAnswer((_) async => [testTransaction]);
      when(() => mockRemoteDataSource.syncTransaction(any()))
          .thenThrow(ServerException('Transacción rechazada por el servidor'));

      final result = await repository.syncTransactions();

      expect(result, isA<Left<Failure, List<TransactionEntity>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
        },
        (_) => fail('No debería retornar lista'),
      );
    });

    test('debería continuar sincronizando otras transacciones si una falla', () async {
      final txn1 = testTransaction.copyWith(id: 'txn-001');
      final txn2 = testTransaction.copyWith(id: 'txn-002');
      final syncedTxn2 = txn2.copyWith(serverId: 'server-002', syncStatus: SyncStatus.synced);

      when(() => mockLocalDataSource.getPendingTransactions())
          .thenAnswer((_) async => [txn1, txn2]);
      when(() => mockRemoteDataSource.syncTransaction(txn1))
          .thenThrow(ServerException('Error'));
      when(() => mockRemoteDataSource.syncTransaction(txn2))
          .thenAnswer((_) async => syncedTxn2);
      when(() => mockLocalDataSource.updateTransaction(syncedTxn2))
          .thenAnswer((_) async => syncedTxn2);

      final result = await repository.syncTransactions();

      verify(() => mockRemoteDataSource.syncTransaction(txn1)).called(1);
      verify(() => mockRemoteDataSource.syncTransaction(txn2)).called(1);
      verify(() => mockLocalDataSource.updateTransaction(syncedTxn2)).called(1);
    });
  });

  group('getAllTransactions', () {
    test('debería retornar todas las transacciones del almacenamiento local', () async {
      when(() => mockLocalDataSource.getAllTransactions())
          .thenAnswer((_) async => testTransactionList);

      final result = await repository.getAllTransactions();

      expect(result, isA<Right<Failure, List<TransactionEntity>>>());
      result.fold(
        (failure) => fail('No debería retornar failure'),
        (entities) => expect(entities.length, 2),
      );
    });

    test('debería retornar DatabaseFailure cuando falla la consulta', () async {
      when(() => mockLocalDataSource.getAllTransactions())
          .thenThrow(LocalDatabaseException('Error de lectura'));

      final result = await repository.getAllTransactions();

      expect(result, isA<Left<Failure, List<TransactionEntity>>>());
    });
  });

  group('deleteTransaction', () {
    test('debería eliminar la transacción del almacenamiento local', () async {
      when(() => mockLocalDataSource.deleteTransaction(any()))
          .thenAnswer((_) async => {});

      final result = await repository.deleteTransaction('txn-test-123');

      expect(result, isA<Right<Failure, void>>());
      verify(() => mockLocalDataSource.deleteTransaction('txn-test-123')).called(1);
    });

    test('debería manejar error al eliminar transacción inexistente', () async {
      when(() => mockLocalDataSource.deleteTransaction(any()))
          .thenThrow(LocalDatabaseException('No se encontró la transacción'));

      final result = await repository.deleteTransaction('txn-inexistente');

      expect(result, isA<Left<Failure, void>>());
    });
  });
}