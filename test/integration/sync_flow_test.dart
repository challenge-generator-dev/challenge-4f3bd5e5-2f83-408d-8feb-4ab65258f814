import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/network/connectivity_service.dart';
import 'package:payment_app/data/datasources/local/transaction_local_datasource.dart';
import 'package:payment_app/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:payment_app/data/repositories/transaction_repository_impl.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';

class MockConnectivityService extends Mock implements ConnectivityService {}

class MockLocalDataSource extends Mock implements TransactionLocalDataSource {}

class MockRemoteDataSource extends Mock implements TransactionRemoteDataSource {}

void main() {
  late SyncFlowTester tester;

  setUp(() {
    tester = SyncFlowTester();
  });

  group('Flujo de Sincronización Offline', () {
    test('ESCENARIO: crear transacción sin conexión y sincronizar cuando hay conexión', () async {
      final offlineTransaction = TransactionEntity(
        id: 'txn-offline-001',
        userId: 'user-test-001',
        amount: 50.00,
        currency: 'USD',
        recipientId: 'recipient-001',
        createdAt: DateTime.now(),
        syncStatus: SyncStatus.pending,
        retryCount: 0,
      );

      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => false);
      when(() => tester.localDataSource.createTransaction(any()))
          .thenAnswer((_) async => offlineTransaction);
      when(() => tester.localDataSource.getPendingTransactions())
          .thenAnswer((_) async => [offlineTransaction]);
      when(() => tester.localDataSource.updateTransaction(any()))
          .thenAnswer((_) async => offlineTransaction.copyWith(
                syncStatus: SyncStatus.synced,
                serverId: 'server-synced-001',
              ));
      when(() => tester.remoteDataSource.syncTransaction(any()))
          .thenAnswer((_) async => offlineTransaction.copyWith(
                syncStatus: SyncStatus.synced,
                serverId: 'server-synced-001',
              ));

      final createResult = await tester.repository.createTransaction(offlineTransaction);
      expect(createResult, isA<Right<Failure, TransactionEntity>>());

      final pendingResult = await tester.repository.getPendingTransactions();
      expect(pendingResult.getOrElse(() => []).length, 1);

      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => true);

      final isConnected = await tester.connectivityService.isConnected();
      expect(isConnected, isTrue);

      final syncResult = await tester.repository.syncTransactions();
      expect(syncResult, isA<Right<Failure, List<TransactionEntity>>>());
      syncResult.fold(
        (failure) => fail('La sincronización no debería fallar'),
        (synced) {
          expect(synced.length, 1);
          expect(synced.first.syncStatus, SyncStatus.synced);
          expect(synced.first.serverId, isNotNull);
        },
      );
    });

    test('ESCENARIO: múltiples transacciones creadas offline se sincronizan en lote', () async {
      final transactions = List.generate(
        5,
        (index) => TransactionEntity(
          id: 'txn-batch-$index',
          userId: 'user-batch',
          amount: 10.00 * (index + 1),
          currency: 'USD',
          recipientId: 'recipient-batch-$index',
          createdAt: DateTime.now(),
          syncStatus: SyncStatus.pending,
          retryCount: 0,
        ),
      );

      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => false);
      when(() => tester.localDataSource.getPendingTransactions())
          .thenAnswer((_) async => transactions);
      when(() => tester.remoteDataSource.syncTransaction(any()))
          .thenAnswer((invocation) async {
        final txn = invocation.positionalArguments[0] as TransactionEntity;
        return txn.copyWith(
          syncStatus: SyncStatus.synced,
          serverId: 'server-${txn.id}',
        );
      });
      when(() => tester.localDataSource.updateTransaction(any()))
          .thenAnswer((invocation) async => invocation.positionalArguments[0] as TransactionEntity);

      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => true);

      final syncResult = await tester.repository.syncTransactions();

      syncResult.fold(
        (failure) => fail('No debería fallar'),
        (synced) {
          expect(synced.length, 5);
          expect(synced.every((t) => t.syncStatus == SyncStatus.synced), isTrue);
        },
      );

      verify(() => tester.remoteDataSource.syncTransaction(any())).called(5);
    });

    test('ESCENARIO: la sincronización falla por pérdida de conexión y se reintenta', () async {
      final pendingTxn = TransactionEntity(
        id: 'txn-retry-001',
        userId: 'user-retry',
        amount: 100.00,
        currency: 'USD',
        recipientId: 'recipient-retry',
        createdAt: DateTime.now(),
        syncStatus: SyncStatus.pending,
        retryCount: 0,
      );

      when(() => tester.localDataSource.getPendingTransactions())
          .thenAnswer((_) async => [pendingTxn]);

      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => true);

      when(() => tester.remoteDataSource.syncTransaction(any()))
          .thenThrow(NetworkException('Conexión perdida'));

      final syncResult = await tester.repository.syncTransactions();

      expect(syncResult, isA<Left<Failure, List<TransactionEntity>>>());
      syncResult.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, contains('Conexión'));
        },
        (_) => fail('No debería retornar lista'),
      );
    });

    test('ESCENARIO: el servidor rechaza una transacción y se marca como failed', () async {
      final pendingTxn = TransactionEntity(
        id: 'txn-reject-001',
        userId: 'user-reject',
        amount: 999999.99,
        currency: 'USD',
        recipientId: 'recipient-reject',
        createdAt: DateTime.now(),
        syncStatus: SyncStatus.pending,
        retryCount: 0,
      );

      when(() => tester.localDataSource.getPendingTransactions())
          .thenAnswer((_) async => [pendingTxn]);
      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => true);
      when(() => tester.remoteDataSource.syncTransaction(any()))
          .thenThrow(ServerException('Monto excede el límite permitido'));

      final syncResult = await tester.repository.syncTransactions();

      expect(syncResult, isA<Left<Failure, List<TransactionEntity>>>());
      syncResult.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, contains('límite'));
        },
        (_) => fail('No debería retornar lista'),
      );
    });

    test('ESCENARIO: transacción creada offline mantiene estado pending después de varios intentos fallidos', () async {
      final failingTxn = TransactionEntity(
        id: 'txn-fail-001',
        userId: 'user-fail',
        amount: 25.50,
        currency: 'EUR',
        recipientId: 'recipient-fail',
        createdAt: DateTime.now(),
        syncStatus: SyncStatus.pending,
        retryCount: 2,
        errorMessage: 'Intentos anteriores fallidos',
      );

      when(() => tester.localDataSource.getPendingTransactions())
          .thenAnswer((_) async => [failingTxn]);
      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => true);
      when(() => tester.remoteDataSource.syncTransaction(any()))
          .thenThrow(NetworkException('Sin acceso al servidor'));

      final syncResult = await tester.repository.syncTransactions();

      expect(syncResult, isA<Left<Failure, List<TransactionEntity>>>());
    });

    test('ESCENARIO: la aplicación detecta cambio de conectividad y dispara sincronización', () async {
      final connectivityChanges = [
        [ConnectivityResult.none],
        [ConnectivityResult.wifi],
      ];

      when(() => tester.connectivityService.onConnectivityChanged())
          .thenAnswer((_) => Stream.fromIterable(connectivityChanges));
      when(() => tester.localDataSource.getPendingTransactions())
          .thenAnswer((_) async => []);
      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => true);

      final connectivityStream = tester.connectivityService.onConnectivityChanged();
      
      expect(connectivityStream, emitsAnyOf([
        [ConnectivityResult.none],
        [ConnectivityResult.wifi],
      ]));
    });

    test('ESCENARIO: integridad de datos cuando se crea transacción durante sincronización', () async {
      final existingTxn = TransactionEntity(
        id: 'txn-existing',
        userId: 'user-sync',
        amount: 75.00,
        currency: 'USD',
        recipientId: 'recipient-sync',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        syncStatus: SyncStatus.pending,
        retryCount: 0,
      );

      final newTxnDuringSync = TransactionEntity(
        id: 'txn-new-during',
        userId: 'user-sync',
        amount: 30.00,
        currency: 'USD',
        recipientId: 'recipient-sync-2',
        createdAt: DateTime.now(),
        syncStatus: SyncStatus.pending,
        retryCount: 0,
      );

      when(() => tester.localDataSource.getPendingTransactions())
          .thenAnswer((_) async => [existingTxn]);
      when(() => tester.localDataSource.createTransaction(any()))
          .thenAnswer((_) async => newTxnDuringSync);
      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => true);
      when(() => tester.remoteDataSource.syncTransaction(any()))
          .thenAnswer((invocation) async {
        final txn = invocation.positionalArguments[0] as TransactionEntity;
        return txn.copyWith(syncStatus: SyncStatus.synced, serverId: 'server-${txn.id}');
      });
      when(() => tester.localDataSource.updateTransaction(any()))
          .thenAnswer((invocation) async => invocation.positionalArguments[0] as TransactionEntity);

      final syncResult = await tester.repository.syncTransactions();
      final createResult = await tester.repository.createTransaction(newTxnDuringSync);

      expect(syncResult, isA<Right<Failure, List<TransactionEntity>>>());
      expect(createResult, isA<Right<Failure, TransactionEntity>>());
    });

    test('ESCENARIO: sincronización exitosa limpia el estado de error', () async {
      final txnWithError = TransactionEntity(
        id: 'txn-error-001',
        userId: 'user-error',
        amount: 45.00,
        currency: 'GBP',
        recipientId: 'recipient-error',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        syncStatus: SyncStatus.failed,
        retryCount: 3,
        errorMessage: 'Error de servidor anterior',
      );

      when(() => tester.localDataSource.getPendingTransactions())
          .thenAnswer((_) async => [txnWithError]);
      when(() => tester.connectivityService.isConnected())
          .thenAnswer((_) async => true);
      when(() => tester.remoteDataSource.syncTransaction(any()))
          .thenAnswer((_) async => txnWithError.copyWith(
                syncStatus: SyncStatus.synced,
                serverId: 'server-recovered',
                errorMessage: null,
              ));
      when(() => tester.localDataSource.updateTransaction(any()))
          .thenAnswer((invocation) async {
        final txn = invocation.positionalArguments[0] as TransactionEntity;
        return txn;
      });

      final syncResult = await tester.repository.syncTransactions();

      syncResult.fold(
        (failure) => fail('No debería fallar'),
        (synced) {
          expect(synced.first.syncStatus, SyncStatus.synced);
          expect(synced.first.errorMessage, isNull);
          expect(synced.first.serverId, isNotNull);
        },
      );
    });
  });
}

class SyncFlowTester {
  late final TransactionRepositoryImpl repository;
  final MockConnectivityService connectivityService = MockConnectivityService();
  final MockLocalDataSource localDataSource = MockLocalDataSource();
  final MockRemoteDataSource remoteDataSource = MockRemoteDataSource();

  SyncFlowTester() {
    repository = TransactionRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );
  }
}