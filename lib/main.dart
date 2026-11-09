import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:payment_app/core/network/connectivity_service.dart';
import 'package:payment_app/core/network/network_info.dart';
import 'package:payment_app/data/datasources/local/database_helper.dart';
import 'package:payment_app/data/datasources/local/transaction_local_datasource.dart';
import 'package:payment_app/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:payment_app/data/repositories/transaction_repository_impl.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app/domain/usecases/create_transaction_usecase.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions_usecase.dart';
import 'package:payment_app/domain/usecases/sync_transactions_usecase.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/blocs/sync/sync_bloc.dart';
import 'package:payment_app/presentation/screens/payment_screen.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initDependencies();
  runApp(const PaymentApp());
}

Future<void> _initDependencies() async {
  // Database
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initDatabase();
  getIt.registerSingleton<DatabaseHelper>(databaseHelper);

  // Network
  final connectivityService = ConnectivityService();
  getIt.registerSingleton<ConnectivityService>(connectivityService);
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(connectivityService));

  // Data sources
  getIt.registerSingleton<TransactionLocalDataSource>(
    TransactionLocalDataSourceImpl(databaseHelper: databaseHelper),
  );
  getIt.registerSingleton<TransactionRemoteDataSource>(
    TransactionRemoteDataSourceImpl(),
  );

  // Repository
  getIt.registerSingleton<TransactionRepository>(
    TransactionRepositoryImpl(
      localDataSource: getIt<TransactionLocalDataSource>(),
      remoteDataSource: getIt<TransactionRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Use cases
  getIt.registerSingleton<CreateTransactionUseCase>(
    CreateTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerSingleton<GetPendingTransactionsUseCase>(
    GetPendingTransactionsUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerSingleton<SyncTransactionsUseCase>(
    SyncTransactionsUseCase(getIt<TransactionRepository>()),
  );
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionBloc(
            createTransactionUseCase: getIt<CreateTransactionUseCase>(),
            getPendingTransactionsUseCase: getIt<GetPendingTransactionsUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => SyncBloc(
            syncTransactionsUseCase: getIt<SyncTransactionsUseCase>(),
            networkInfo: getIt<NetworkInfo>(),
          )..add(StartSync()),
        ),
      ],
      child: MaterialApp(
        title: 'Payment App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const PaymentScreen(),
      ),
    );
  }
}