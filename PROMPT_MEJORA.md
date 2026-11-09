# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `lib/data/datasources/local/database_helper.dart` — El topic pide persistencia: este archivo es el ejercicio.
- `lib/data/repositories/transaction_repository_impl.dart` — El topic pide persistencia: este archivo es el ejercicio.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `lib/presentation/blocs/sync/sync_bloc.dart` — `ConnectivityService.isConnected`: Se invoca `isConnected` sobre `ConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/presentation/blocs/sync/sync_bloc.dart` — `ConnectivityService.checkConnectivity`: Se invoca `checkConnectivity` sobre `ConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.createTransaction`: Se invoca `createTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.getPendingTransactions`: Se invoca `getPendingTransactions` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.updateTransaction`: Se invoca `updateTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/transaction_repository_test.dart` — `MockRemoteDataSource.syncTransaction`: Se invoca `syncTransaction` sobre `MockRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.getAllTransactions`: Se invoca `getAllTransactions` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.deleteTransaction`: Se invoca `deleteTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/integration/sync_flow_test.dart` — `MockConnectivityService.isConnected`: Se invoca `isConnected` sobre `MockConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/integration/sync_flow_test.dart` — `MockLocalDataSource.createTransaction`: Se invoca `createTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/integration/sync_flow_test.dart` — `MockLocalDataSource.getPendingTransactions`: Se invoca `getPendingTransactions` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/integration/sync_flow_test.dart` — `MockLocalDataSource.updateTransaction`: Se invoca `updateTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/integration/sync_flow_test.dart` — `MockRemoteDataSource.syncTransaction`: Se invoca `syncTransaction` sobre `MockRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `test/integration/sync_flow_test.dart` — `MockConnectivityService.onConnectivityChanged`: Se invoca `onConnectivityChanged` sobre `MockConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
flutter pub get && flutter analyze
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior

### Brecha de conocimiento
Maneja estado y flujos asincronicos con persistencia local y sincronizacion posterior

### Misión / candidato
Soportar operacion sin conexion en la app de pagos

### Datos adicionales
Candidato con 4 años en Flutter

### Reto
- Tema: persistencia local y modo offline (reg 1109)
- Seniority: senior-l2
- Tipo: practical
- Título: Implementación de persistencia local y sincronización en modo offline para una aplicación de pagos
- Tiempo estimado: 2 semanas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Diseño del modelo de persistencia local — objetivo: Definir la estructura de datos para la persistencia local y establecer las reglas para la sincronización posterior. — entregable (NO resolver): Modelo de datos para persistencia local y reglas de sincronización.
- Fase 2: Implementación de la persistencia local — objetivo: Implementar la funcionalidad para almacenar transacciones localmente cuando no hay conexión. — entregable (NO resolver): Implementación de la funcionalidad de persistencia local para transacciones.
- Fase 3: Sincronización de datos con el servidor — objetivo: Implementar la lógica para sincronizar los datos almacenados localmente con el servidor una vez que la conexión sea restablecida. — entregable (NO resolver): Implementación de la funcionalidad de sincronización de datos con el servidor.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: pubspec.yaml ===
name: payment_app
description: Aplicación de pagos con persistencia local y sincronización offline.
version: 1.0.0+1
environment:
  sdk: '>=3.6.0 <4.0.0'
  flutter: '>=3.27.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: 8.1.6
  equatable: 2.0.5
  dartz: 0.10.1
  get_it: 7.7.0
  sqflite: 2.3.3
  path: 1.9.0
  connectivity_plus: 6.0.5
  http: 1.2.2
  uuid: 4.4.2
  intl: 0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: 9.1.7
  mocktail: 1.0.4

flutter:
  uses-material-design: true
  assets:
    - assets/translations/

// === ARCHIVO: lib/main.dart ===
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

// === ARCHIVO: lib/domain/entities/transaction_entity.dart ===
part of 'package:payment_app/domain/entities/entities.dart';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// Representa una transacción de pago en el dominio.
/// Inmutable para garantizar consistencia en el manejo de estado.
class TransactionEntity extends Equatable {
  final String id;
  final String userId;
  final double amount;
  final String currency;
  final String recipientId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final SyncStatus syncStatus;
  final int retryCount;
  final String? serverId;
  final String? errorMessage;

  /// Crea una nueva transacción.
  /// [id] se genera automáticamente si no se proporciona.
  TransactionEntity({
    String? id,
    required this.userId,
    required this.amount,
    this.currency = 'USD',
    required this.recipientId,
    DateTime? createdAt,
    this.updatedAt,
    this.syncStatus = SyncStatus.pending,
    this.retryCount = 0,
    this.serverId,
    this.errorMessage,
  }) : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  /// Crea una copia de la transacción con los campos actualizados.
  /// Útil para actualizar estados sin mutar la instancia original.
  TransactionEntity copyWith({
    String? id,
    String? userId,
    double? amount,
    String? currency,
    String? recipientId,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
    int? retryCount,
    String? serverId,
    String? errorMessage,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      recipientId: recipientId ?? this.recipientId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      retryCount: retryCount ?? this.retryCount,
      serverId: serverId ?? this.serverId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Convierte la entidad a un mapa para persistencia.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'currency': currency,
      'recipientId': recipientId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'syncStatus': syncStatus.toString().split('.').last,
      'retryCount': retryCount,
      'serverId': serverId,
      'errorMessage': errorMessage,
    };
  }

  /// Crea una entidad desde un mapa (ej. desde la base de datos).
  factory TransactionEntity.fromJson(Map<String, dynamic> json) {
    return TransactionEntity(
      id: json['id'],
      userId: json['userId'],
      amount: json['amount'] is int
          ? (json['amount'] as int).toDouble()
          : json['amount'] as double,
      currency: json['currency'] ?? 'USD',
      recipientId: json['recipientId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      syncStatus: SyncStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['syncStatus'],
        orElse: () => SyncStatus.pending,
      ),
      retryCount: json['retryCount'] ?? 0,
      serverId: json['serverId'],
      errorMessage: json['errorMessage'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        amount,
        currency,
        recipientId,
        createdAt,
        updatedAt,
        syncStatus,
        retryCount,
        serverId,
        errorMessage,
      ];
}

// === ARCHIVO: lib/domain/entities/sync_status.dart ===
/// Define los estados posibles de sincronización de una transacción.
enum SyncStatus {
  /// La transacción está pendiente de sincronización con el servidor.
  pending,

  /// La transacción está en proceso de sincronización.
  syncing,

  /// La transacción se sincronizó correctamente con el servidor.
  synced,

  /// La sincronización falló y se reintentará.
  failed,

  /// La transacción fue rechazada por el servidor (ej. duplicada o inválida).
  rejected,
}

// === ARCHIVO: lib/domain/repositories/transaction_repository.dart ===
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

// === ARCHIVO: lib/domain/usecases/create_transaction_usecase.dart ===
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

// === ARCHIVO: lib/domain/usecases/get_pending_transactions_usecase.dart ===
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

// === ARCHIVO: lib/domain/usecases/sync_transactions_usecase.dart ===
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class SyncTransactionsUseCase {
  final TransactionRepository repository;

  static const int maxRetryCount = 3;
  static const int retryDelaySeconds = 5;

  SyncTransactionsUseCase(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call() async {
    return await repository.syncTransactions();
  }

  Future<Either<Failure, SyncResult>> callWithRetryPolicy() async {
    final result = await repository.getPendingTransactions();

    return result.fold(
      (failure) => Left(failure),
      (pendingTransactions) async {
        if (pendingTransactions.isEmpty) {
          return const Right(SyncResult(
            syncedCount: 0,
            failedCount: 0,
            totalCount: 0,
          ));
        }

        final toRetry = pendingTransactions
            .where((t) =>
                t.syncStatus == SyncStatus.failed &&
                t.retryCount < maxRetryCount)
            .toList();

        final toSync = pendingTransactions
            .where((t) => t.syncStatus == SyncStatus.pending)
            .toList();

        final allToSync = [...toSync, ...toRetry];
        var syncedCount = 0;
        var failedCount = 0;

        for (final transaction in allToSync) {
          final syncResult = await _syncSingleTransaction(transaction);

          syncResult.fold(
            (failure) => failedCount++,
            (synced) => syncedCount++,
          );
        }

        return Right(SyncResult(
          syncedCount: syncedCount,
          failedCount: failedCount,
          totalCount: allToSync.length,
        ));
      },
    );
  }

  Future<Either<Failure, TransactionEntity>> _syncSingleTransaction(
      TransactionEntity transaction) async {
    final result = await repository.syncTransactions();

    return result.fold(
      (failure) => Left(failure),
      (syncedTransactions) {
        final synced = syncedTransactions.firstWhere(
          (t) => t.id == transaction.id,
          orElse: () => transaction,
        );

        if (synced.syncStatus == SyncStatus.synced) {
          return Right(synced);
        } else {
          return Left(SyncFailure(
            'Error al sincronizar la transacción ${transaction.id}: ${synced.errorMessage ?? "Error desconocido"}',
          ));
        }
      },
    );
  }

  Future<Either<Failure, List<TransactionEntity>>>
      syncTransactionsByUserId(String userId) async {
    if (userId.isEmpty) {
      return const Left(ValidationFailure('El ID de usuario no puede estar vacío'));
    }

    final pendingResult = await repository.getPendingTransactions();

    return pendingResult.fold(
      (failure) => Left(failure),
      (pendingTransactions) async {
        final userTransactions = pendingTransactions
            .where((t) => t.userId == userId)
            .toList();

        if (userTransactions.isEmpty) {
          return const Right([]);
        }

        final allResults = <TransactionEntity>[];

        for (final transaction in userTransactions) {
          final updatedTransaction = transaction.copyWith(
            syncStatus: SyncStatus.syncing,
            updatedAt: DateTime.now(),
          );

          final updateResult = await repository.updateTransaction(updatedTransaction);

          await Future.delayed(const Duration(milliseconds: 100));

          allResults.add(updatedTransaction);
        }

        return Right(allResults);
      },
    );
  }
}

class SyncResult {
  final int syncedCount;
  final int failedCount;
  final int totalCount;

  const SyncResult({
    required this.syncedCount,
    required this.failedCount,
    required this.totalCount,
  });

  double get successRate =>
      totalCount > 0 ? (syncedCount / totalCount) * 100 : 0;

  bool get hasFailures => failedCount > 0;

  @override
  String toString() =>
      'SyncResult(synced: $syncedCount, failed: $failedCount, total: $totalCount, successRate: ${successRate.toStringAsFixed(1)}%)';
}

class SyncFailure extends Failure {
  final String message;

  const SyncFailure(this.message);

  @override
  String toString() => 'SyncFailure: $message';
}

class ValidationFailure extends Failure {
  final String message;

  const ValidationFailure(this.message);

  @override
  String toString() => 'ValidationFailure: $message';
}

// === ARCHIVO: lib/data/models/transaction_model.dart ===
part of 'package:payment_app/data/models/models.dart';

class TransactionModel extends Equatable {
  final String id;
  final String userId;
  final double amount;
  final String currency;
  final String recipientId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String syncStatus;
  final int retryCount;
  final String? serverId;
  final String? errorMessage;

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.recipientId,
    required this.createdAt,
    this.updatedAt,
    required this.syncStatus,
    required this.retryCount,
    this.serverId,
    this.errorMessage,
  });

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      userId: entity.userId,
      amount: entity.amount,
      currency: entity.currency,
      recipientId: entity.recipientId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      syncStatus: entity.syncStatus.name,
      retryCount: entity.retryCount,
      serverId: entity.serverId,
      errorMessage: entity.errorMessage,
    );
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      userId: userId,
      amount: amount,
      currency: currency,
      recipientId: recipientId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: _parseSyncStatus(syncStatus),
      retryCount: retryCount,
      serverId: serverId,
      errorMessage: errorMessage,
    );
  }

  static SyncStatus _parseSyncStatus(String status) {
    return SyncStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => SyncStatus.pending,
    );
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      recipientId: json['recipient_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      syncStatus: json['sync_status'] as String,
      retryCount: json['retry_count'] as int,
      serverId: json['server_id'] as String?,
      errorMessage: json['error_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'currency': currency,
      'recipient_id': recipientId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'sync_status': syncStatus,
      'retry_count': retryCount,
      'server_id': serverId,
      'error_message': errorMessage,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'currency': currency,
      'recipient_id': recipientId,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'sync_status': syncStatus,
      'retry_count': retryCount,
      'server_id': serverId,
      'error_message': errorMessage,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'] as String,
      recipientId: map['recipient_id'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int)
          : null,
      syncStatus: map['sync_status'] as String,
      retryCount: map['retry_count'] as int,
      serverId: map['server_id'] as String?,
      errorMessage: map['error_message'] as String?,
    );
  }

  TransactionModel copyWith({
    String? id,
    String? userId,
    double? amount,
    String? currency,
    String? recipientId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    int? retryCount,
    String? serverId,
    String? errorMessage,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      recipientId: recipientId ?? this.recipientId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      retryCount: retryCount ?? this.retryCount,
      serverId: serverId ?? this.serverId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        amount,
        currency,
        recipientId,
        createdAt,
        updatedAt,
        syncStatus,
        retryCount,
        serverId,
        errorMessage,
      ];
}

// === ARCHIVO: lib/data/datasources/local/database_helper.dart ===
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DatabaseHelper {
  Future<void> initDatabase();
  Database get database;
  Future<void> close();
}

class DatabaseHelperImpl implements DatabaseHelper {
  static const String _databaseName = 'payment_app.db';
  static const int _databaseVersion = 1;

  Database? _database;

  @override
  Future<void> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        amount REAL NOT NULL,
        currency TEXT NOT NULL,
        recipient_id TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER,
        sync_status TEXT NOT NULL,
        retry_count INTEGER NOT NULL DEFAULT 0,
        server_id TEXT,
        error_message TEXT
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_sync_status 
      ON transactions(sync_status)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_user_id 
      ON transactions(user_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_created_at 
      ON transactions(created_at)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Manejo de migraciones futuras
  }

  @override
  Database get database {
    if (_database == null) {
      throw Exception('Database not initialized. Call initDatabase() first.');
    }
    return _database!;
  }

  @override
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}

// === ARCHIVO: lib/data/datasources/local/transaction_local_datasource.dart ===
import 'package:sqflite/sqflite.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/data/models/transaction_model.dart';
import 'package:payment_app/data/datasources/local/database_helper.dart';

abstract class TransactionLocalDataSource {
  Future<TransactionModel> createTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getPendingTransactions();
  Future<TransactionModel> updateTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String transactionId);
  Future<TransactionModel?> getTransactionById(String id);
  Future<List<TransactionModel>> getTransactionsByUserId(String userId);
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final DatabaseHelper databaseHelper;

  static const String _tableName = 'transactions';

  TransactionLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TransactionModel> createTransaction(TransactionModel transaction) async {
    try {
      final db = databaseHelper.database;
      await db.insert(
        _tableName,
        transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return transaction;
    } on DatabaseException catch (e) {
      throw LocalDatabaseException('Failed to create transaction: ${e.message}');
    } catch (e) {
      throw LocalDatabaseException('Unexpected error creating transaction: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getPendingTransactions() async {
    try {
      final db = databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'sync_status = ?',
        whereArgs: ['pending'],
        orderBy: 'created_at ASC',
      );
      return maps.map((map) => TransactionModel.fromMap(map)).toList();
    } on DatabaseException catch (e) {
      throw LocalDatabaseException('Failed to get pending transactions: ${e.message}');
    } catch (e) {
      throw LocalDatabaseException('Unexpected error getting pending transactions: $e');
    }
  }

  @override
  Future<TransactionModel> updateTransaction(TransactionModel transaction) async {
    try {
      final db = databaseHelper.database;
      final updatedTransaction = transaction.copyWith(
        updatedAt: DateTime.now(),
      );
      final rowsAffected = await db.update(
        _tableName,
        updatedTransaction.toMap(),
        where: 'id = ?',
        whereArgs: [transaction.id],
      );
      if (rowsAffected == 0) {
        throw LocalDatabaseException(
          'Transaction not found with id: ${transaction.id}'
        );
      }
      return updatedTransaction;
    } on DatabaseException catch (e) {
      throw LocalDatabaseException('Failed to update transaction: ${e.message}');
    } catch (e) {
      if (e is LocalDatabaseException) rethrow;
      throw LocalDatabaseException('Unexpected error updating transaction: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final db = databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        orderBy: 'created_at DESC',
      );
      return maps.map((map) => TransactionModel.fromMap(map)).toList();
    } on DatabaseException catch (e) {
      throw LocalDatabaseException('Failed to get all transactions: ${e.message}');
    } catch (e) {
      throw LocalDatabaseException('Unexpected error getting all transactions: $e');
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      final db = databaseHelper.database;
      final rowsAffected = await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [transactionId],
      );
      if (rowsAffected == 0) {
        throw LocalDatabaseException(
          'Transaction not found with id: $transactionId'
        );
      }
    } on DatabaseException catch (e) {
      throw LocalDatabaseException('Failed to delete transaction: ${e.message}');
    } catch (e) {
      if (e is LocalDatabaseException) rethrow;
      throw LocalDatabaseException('Unexpected error deleting transaction: $e');
    }
  }

  @override
  Future<TransactionModel?> getTransactionById(String id) async {
    try {
      final db = databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isEmpty) {
        return null;
      }
      return TransactionModel.fromMap(maps.first);
    } on DatabaseException catch (e) {
      throw LocalDatabaseException('Failed to get transaction by id: ${e.message}');
    } catch (e) {
      throw LocalDatabaseException('Unexpected error getting transaction by id: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByUserId(String userId) async {
    try {
      final db = databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'created_at DESC',
      );
      return maps.map((map) => TransactionModel.fromMap(map)).toList();
    } on DatabaseException catch (e) {
      throw LocalDatabaseException('Failed to get transactions by user id: ${e.message}');
    } catch (e) {
      throw LocalDatabaseException('Unexpected error getting transactions by user id: $e');
    }
  }
}

// === ARCHIVO: lib/data/datasources/remote/transaction_remote_datasource.dart ===
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:payment_app/core/constants/app_constants.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/data/models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<TransactionModel> createTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getPendingTransactions();
  Future<TransactionModel> updateTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> syncTransactions(List<TransactionModel> transactions);
  Future<void> deleteTransaction(String transactionId);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  TransactionRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = AppConstants.baseApiUrl,
  });

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  @override
  Future<TransactionModel> createTransaction(TransactionModel transaction) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/transactions'),
        headers: _headers,
        body: json.encode(transaction.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;
        return TransactionModel.fromJson(decoded);
      } else {
        throw ServerException(
          message: 'Failed to create transaction: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkException(message: 'Network error creating transaction: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(message: 'Unexpected error creating transaction: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getPendingTransactions() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/transactions?status=pending'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> decoded = json.decode(response.body);
        return decoded
            .map((json) => TransactionModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to get pending transactions: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkException(message: 'Network error fetching pending transactions: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(message: 'Unexpected error fetching pending transactions: $e');
    }
  }

  @override
  Future<TransactionModel> updateTransaction(TransactionModel transaction) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/transactions/${transaction.serverId ?? transaction.id}'),
        headers: _headers,
        body: json.encode(transaction.toJson()),
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;
        return TransactionModel.fromJson(decoded);
      } else {
        throw ServerException(
          message: 'Failed to update transaction: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkException(message: 'Network error updating transaction: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(message: 'Unexpected error updating transaction: $e');
    }
  }

  @override
  Future<List<TransactionModel>> syncTransactions(List<TransactionModel> transactions) async {
    if (transactions.isEmpty) return [];
    
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/transactions/sync'),
        headers: _headers,
        body: json.encode({
          'transactions': transactions.map((t) => t.toJson()).toList(),
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = json.decode(response.body);
        final List<dynamic> syncedList = decoded['synced'] ?? decoded['transactions'] ?? [];
        return syncedList
            .map((json) => TransactionModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to sync transactions: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkException(message: 'Network error syncing transactions: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(message: 'Unexpected error syncing transactions: $e');
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/transactions/$transactionId'),
        headers: _headers,
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException(
          message: 'Failed to delete transaction: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw NetworkException(message: 'Network error deleting transaction: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(message: 'Unexpected error deleting transaction: $e');
    }
  }
}

// === ARCHIVO: lib/data/repositories/transaction_repository_impl.dart ===
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

// === ARCHIVO: lib/core/errors/exceptions.dart ===
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

// === ARCHIVO: lib/core/constants/app_constants.dart ===
package payment_app.core.constants;

class AppConstants {
  AppConstants._();

  // API Configuration
  static const String baseUrl = 'https://api.payments.example.com';
  static const String apiVersion = 'v1';
  static const String transactionsEndpoint = '/transactions';
  static const String usersEndpoint = '/users';
  static const String syncEndpoint = '/sync';

  // Timeouts (in milliseconds)
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;
  static const int databaseOperationTimeout = 10000;

  // Retry Configuration
  static const int maxRetryCount = 3;
  static const int retryDelayMs = 2000;
  static const int retryBackoffMultiplier = 2;
  static const int maxRetryDelayMs = 30000;

  // Database Configuration
  static const String databaseName = 'payment_app.db';
  static const int databaseVersion = 1;
  static const int databaseVersionOld = 1;

  // Table Names
  static const String transactionsTable = 'transactions';
  static const String usersTable = 'users';
  static const String syncQueueTable = 'sync_queue';
  static const String settingsTable = 'settings';

  // Sync Configuration
  static const int syncBatchSize = 50;
  static const int syncIntervalMinutes = 5;
  static const int maxPendingTransactions = 1000;
  static const int syncRetryIntervalMinutes = 15;

  // Transaction Limits
  static const double maxTransactionAmount = 10000.0;
  static const double minTransactionAmount = 0.01;
  static const String defaultCurrency = 'USD';

  // Network Configuration
  static const int connectivityCheckIntervalSeconds = 30;
  static const int networkTimeoutSeconds = 45;
  static const List<String> allowedCurrencies = [
    'USD',
    'EUR',
    'GBP',
    'MXN',
    'COP',
    'ARS',
    'BRL',
  ];

  // UI Configuration
  static const int maxTransactionHistoryItems = 100;
  static const int animationDurationMs = 300;
  static const int debounceDelayMs = 500;

  // Security Configuration
  static const int tokenRefreshBufferMinutes = 5;
  static const int maxAuthAttempts = 3;
  static const int lockoutDurationMinutes = 30;

  // Validation
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
  static final RegExp uuidRegex = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );

  // Logging
  static const bool enableDebugLogs = true;
  static const bool enableNetworkLogs = false;
  static const bool enableDatabaseLogs = false;

  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enableAutoSync = true;
  static const bool enablePushNotifications = false;
  static const bool enableBiometricAuth = false;
  static const bool enableTransactionReceipts = true;

  // Cache Configuration
  static const int cacheExpirationHours = 24;
  static const int maxCacheSizeMb = 50;
  static const bool enableCacheAnalytics = true;

  // Date Formats
  static const String iso8601Format = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayTimeFormat = 'HH:mm';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';

  // Error Messages
  static const String genericErrorMessage = 'An unexpected error occurred. Please try again.';
  static const String networkErrorMessage = 'No internet connection. Your transaction will be saved and synced when connection is restored.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String validationErrorMessage = 'Please check your input and try again.';
  static const String syncErrorMessage = 'Failed to sync. Will retry automatically.';

  // Success Messages
  static const String transactionCreatedMessage = 'Transaction created successfully.';
  static const String transactionSyncedMessage = 'Transaction synced successfully.';
  static const String transactionPendingMessage = 'Transaction saved locally. Will sync when online.';
}

// === ARCHIVO: android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Permisos de red -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CHANGE_NETWORK_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />

    <!-- Permisos de conectividad móvil -->
    <uses-permission android:name="android.permission.ACCESS_MOBILE_STATE" />

    <!-- Permisos de almacenamiento (para caché y base de datos local) -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"
        android:maxSdkVersion="32" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
        android:maxSdkVersion="29" />

    <!-- Permisos de vibración para notificaciones -->
    <uses-permission android:name="android.permission.VIBRATE" />

    <!-- Permisos de wake lock para sincronización en background -->
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />

    <!-- Permisos para foreground service (sincronización) -->
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC" />

    <!-- Permisos de biometric -->
    <uses-permission android:name="android.permission.USE_BIOMETRIC" />
    <uses-permission android:name="android.permission.USE_FINGERPRINT" />

    <!-- Configuración de la aplicación -->
    <application
        android:label="Payment App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:allowBackup="true"
        android:fullBackupContent="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:backup="true"
        android:hardwareAccelerated="true"
        android:largeHeap="true"
        android:usesCleartextTraffic="false"
        android:networkSecurityConfig="@xml/network_security_config">

        <!-- Activity principal -->
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
            <!-- Deep links -->
            <intent-filter android:autoVerify="true">
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data
                    android:scheme="https"
                    android:host="payments.example.com" />
            </intent-filter>
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data
                    android:scheme="paymentapp"
                    android:host="open" />
            </intent-filter>
        </activity>

        <!-- Servicio de sincronización en background -->
        <service
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"
            android:exported="false" />
        <service
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
            android:exported="false">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED" />
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED" />
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON" />
            </intent-filter>
        </service>

        <!-- Receptor de conectividad -->
        <receiver
            android:name="com.it_nomads.fluttersecurenestorage.ConnectivityBroadcastReceiver"
            android:exported="false">
            <intent-filter>
                <action android:name="android.net.conn.CONNECTIVITY_CHANGE" />
            </intent-filter>
        </receiver>

        <!-- Meta-data para Flutter -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />

        <!-- Proveedor de seguridad para Flutter -->
        <provider
            android:name="androidx.startup.InitializationProvider"
            android:authorities="${applicationId}.androidx-startup"
            android:exported="false"
            tools:node="merge">
            <meta-data
                android:name="androidx.work.WorkManagerInitializer"
                android:value="androidx.startup"
                tools:node="remove" />
        </provider>
    </application>

    <!-- Queries para deep linking -->
    <queries>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="https" />
        </intent>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="http" />
        </intent>
        <intent>
            <action android:name="android.intent.action.SEND" />
            <data android:mimeType="*/*" />
        </intent>
    </queries>

    <!-- Requerimientos de hardware -->
    <uses-feature
        android:name="android.hardware.telephony"
        android:required="false" />
    <uses-feature
        android:name="android.hardware.wifi"
        android:required="false" />
    <uses-feature
        android:name="android.hardware.nfc"
        android:required="false" />
    <uses-feature
        android:name="android.hardware.fingerprint"
        android:required="false" />
</manifest>

// === ARCHIVO: lib/presentation/blocs/transaction/transaction_event.dart ===
package:payment_app.presentation.blocs.transaction;

import 'package:equatable/equatable.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class CreateTransactionEvent extends TransactionEvent {
  final String userId;
  final double amount;
  final String currency;
  final String recipientId;

  const CreateTransactionEvent({
    required this.userId,
    required this.amount,
    required this.currency,
    required this.recipientId,
  });

  @override
  List<Object?> get props => [userId, amount, currency, recipientId];
}

class LoadTransactionsEvent extends TransactionEvent {
  const LoadTransactionsEvent();
}

class LoadPendingTransactionsEvent extends TransactionEvent {
  const LoadPendingTransactionsEvent();
}

class RetryTransactionEvent extends TransactionEvent {
  final String transactionId;

  const RetryTransactionEvent({required this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}

class DeleteTransactionEvent extends TransactionEvent {
  final String transactionId;

  const DeleteTransactionEvent({required this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}

class RefreshTransactionsEvent extends TransactionEvent {
  const RefreshTransactionsEvent();
}

// === ARCHIVO: lib/presentation/blocs/transaction/transaction_state.dart ===
package:payment_app.presentation.blocs.transaction;

import 'package:equatable/equatable.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionLoading extends TransactionState {
  const TransactionLoading();
}

class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> transactions;
  final int pendingCount;
  final int failedCount;
  final double totalAmount;

  const TransactionLoaded({
    required this.transactions,
    this.pendingCount = 0,
    this.failedCount = 0,
    this.totalAmount = 0.0,
  });

  TransactionLoaded copyWith({
    List<TransactionEntity>? transactions,
    int? pendingCount,
    int? failedCount,
    double? totalAmount,
  }) {
    return TransactionLoaded(
      transactions: transactions ?? this.transactions,
      pendingCount: pendingCount ?? this.pendingCount,
      failedCount: failedCount ?? this.failedCount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [transactions, pendingCount, failedCount, totalAmount];
}

class TransactionCreated extends TransactionState {
  final TransactionEntity transaction;
  final bool isSynced;

  const TransactionCreated({
    required this.transaction,
    this.isSynced = false,
  });

  @override
  List<Object?> get props => [transaction, isSynced];
}

class TransactionDeleted extends TransactionState {
  final String transactionId;

  const TransactionDeleted({required this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}

class TransactionError extends TransactionState {
  final String message;
  final List<TransactionEntity>? cachedTransactions;

  const TransactionError({
    required this.message,
    this.cachedTransactions,
  });

  @override
  List<Object?> get props => [message, cachedTransactions];
}

class TransactionRetrying extends TransactionState {
  final String transactionId;
  final int retryCount;

  const TransactionRetrying({
    required this.transactionId,
    required this.retryCount,
  });

  @override
  List<Object?> get props => [transactionId, retryCount];
}

// === ARCHIVO: lib/presentation/blocs/transaction/transaction_bloc.dart ===
package:payment_app.presentation.blocs.transaction;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/entities/sync_status.dart';
import 'package:payment_app/domain/usecases/create_transaction_usecase.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions_usecase.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app.core.errors.failures';
import 'package:payment_app.presentation.blocs.transaction.transaction_event.dart';
import 'package:payment_app.presentation.blocs.transaction.transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CreateTransactionUseCase createTransactionUseCase;
  final GetPendingTransactionsUseCase getPendingTransactionsUseCase;
  final TransactionRepository transactionRepository;
  final Uuid _uuid = const Uuid();

  TransactionBloc({
    required this.createTransactionUseCase,
    required this.getPendingTransactionsUseCase,
    required this.transactionRepository,
  }) : super(const TransactionInitial()) {
    on<CreateTransactionEvent>(_onCreateTransaction);
    on<LoadTransactionsEvent>(_onLoadTransactions);
    on<LoadPendingTransactionsEvent>(_onLoadPendingTransactions);
    on<RetryTransactionEvent>(_onRetryTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<RefreshTransactionsEvent>(_onRefreshTransactions);
  }

  Future<void> _onCreateTransaction(
    CreateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final transaction = TransactionEntity(
      id: _uuid.v4(),
      userId: event.userId,
      amount: event.amount,
      currency: event.currency,
      recipientId: event.recipientId,
      createdAt: DateTime.now(),
      syncStatus: SyncStatus.pending,
      retryCount: 0,
    );

    final result = await createTransactionUseCase(transaction);

    result.fold(
      (failure) => emit(TransactionError(
        message: _mapFailureToMessage(failure),
      )),
      (createdTransaction) => emit(TransactionCreated(
        transaction: createdTransaction,
        isSynced: createdTransaction.syncStatus == SyncStatus.synced,
      )),
    );
  }

  Future<void> _onLoadTransactions(
    LoadTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final result = await transactionRepository.getAllTransactions();

    result.fold(
      (failure) => emit(TransactionError(
        message: _mapFailureToMessage(failure),
      )),
      (transactions) {
        final pendingCount = transactions
            .where((t) => t.syncStatus == SyncStatus.pending)
            .length;
        final failedCount = transactions
            .where((t) => t.syncStatus == SyncStatus.failed)
            .length;
        final totalAmount = transactions
            .where((t) => t.syncStatus == SyncStatus.synced)
            .fold(0.0, (sum, t) => sum + t.amount);

        emit(TransactionLoaded(
          transactions: transactions,
          pendingCount: pendingCount,
          failedCount: failedCount,
          totalAmount: totalAmount,
        ));
      },
    );
  }

  Future<void> _onLoadPendingTransactions(
    LoadPendingTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    final result = await getPendingTransactionsUseCase();

    result.fold(
      (failure) => emit(TransactionError(
        message: _mapFailureToMessage(failure),
      )),
      (transactions) {
        final pendingCount = transactions
            .where((t) => t.syncStatus == SyncStatus.pending)
            .length;
        final failedCount = transactions
            .where((t) => t.syncStatus == SyncStatus.failed)
            .length;
        final totalAmount = transactions
            .fold(0.0, (sum, t) => sum + t.amount);

        emit(TransactionLoaded(
          transactions: transactions,
          pendingCount: pendingCount,
          failedCount: failedCount,
          totalAmount: totalAmount,
        ));
      },
    );
  }

  Future<void> _onRetryTransaction(
    RetryTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final currentState = state;
    if (currentState is TransactionLoaded) {
      final transactionToRetry = currentState.transactions
          .firstWhere(
            (t) => t.id == event.transactionId,
            orElse: () => throw Exception('Transaction not found'),
          );

      emit(TransactionRetrying(
        transactionId: event.transactionId,
        retryCount: transactionToRetry.retryCount + 1,
      ));

      final updatedTransaction = transactionToRetry.copyWith(
        syncStatus: SyncStatus.pending,
        retryCount: transactionToRetry.retryCount + 1,
        errorMessage: null,
      );

      final result = await transactionRepository.updateTransaction(updatedTransaction);

      result.fold(
        (failure) => emit(TransactionError(
          message: _mapFailureToMessage(failure),
          cachedTransactions: currentState.transactions,
        )),
        (_) => add(const LoadTransactionsEvent()),
      );
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final currentState = state;
    emit(const TransactionLoading());

    final result = await transactionRepository.deleteTransaction(event.transactionId);

    result.fold(
      (failure) => emit(TransactionError(
        message: _mapFailureToMessage(failure),
        cachedTransactions: currentState is TransactionLoaded
            ? currentState.transactions
            : null,
      )),
      (_) => emit(TransactionDeleted(transactionId: event.transactionId)),
    );
  }

  Future<void> _onRefreshTransactions(
    RefreshTransactionsEvent event,
    Emitter<TransactionState> emit,
  ) async {
    add(const LoadTransactionsEvent());
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Error del servidor: ${failure.message}';
    } else if (failure is CacheFailure) {
      return 'Error de almacenamiento local: ${failure.message}';
    } else if (failure is NetworkFailure) {
      return 'Sin conexión a internet. La transacción se guardará localmente.';
    }
    return 'Error desconocido';
  }
}

// === ARCHIVO: lib/presentation/blocs/sync/sync_event.dart ===
import 'package:equatable/equatable.dart';
import 'package:payment_app/domain/entities/entities.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object?> get props => [];
}

class SyncStarted extends SyncEvent {
  const SyncStarted();
}

class SyncRequested extends SyncEvent {
  const SyncRequested();
}

class SyncCompleted extends SyncEvent {
  final List<TransactionEntity> syncedTransactions;

  const SyncCompleted({required this.syncedTransactions});

  @override
  List<Object?> get props => [syncedTransactions];
}

class SyncFailed extends SyncEvent {
  final String errorMessage;
  final int failedCount;

  const SyncFailed({
    required this.errorMessage,
    this.failedCount = 0,
  });

  @override
  List<Object?> get props => [errorMessage, failedCount];
}

class NetworkStatusChanged extends SyncEvent {
  final bool isConnected;

  const NetworkStatusChanged({required this.isConnected});

  @override
  List<Object?> get props => [isConnected];
}

class RetrySyncRequested extends SyncEvent {
  const RetrySyncRequested();
}

class PendingTransactionsLoaded extends SyncEvent {
  final List<TransactionEntity> pendingTransactions;

  const PendingTransactionsLoaded({required this.pendingTransactions});

  @override
  List<Object?> get props => [pendingTransactions];
}

class SchedulePeriodicSync extends SyncEvent {
  final Duration interval;

  const SchedulePeriodicSync({required this.interval});

  @override
  List<Object?> get props => [interval];
}

class CancelPeriodicSync extends SyncEvent {
  const CancelPeriodicSync();
}

class ForceFullSync extends SyncEvent {
  const ForceFullSync();
}

class SyncPaused extends SyncEvent {
  const SyncPaused();
}

class SyncResumed extends SyncEvent {
  const SyncResumed();
}

// === ARCHIVO: lib/presentation/blocs/sync/sync_state.dart ===
import 'package:equatable/equatable.dart';
import 'package:payment_app/domain/entities/entities.dart';

enum SyncSubState {
  initial,
  loading,
  syncing,
  success,
  failure,
  offline,
  paused,
}

class SyncState extends Equatable {
  final SyncSubState subState;
  final List<TransactionEntity> pendingTransactions;
  final List<TransactionEntity> syncedTransactions;
  final int totalPending;
  final int totalSynced;
  final int totalFailed;
  final bool isConnected;
  final String? errorMessage;
  final DateTime? lastSyncTime;
  final double progressPercentage;
  final bool isSyncing;
  final int retryCount;
  final SyncStatus? lastSyncStatus;

  const SyncState({
    this.subState = SyncSubState.initial,
    this.pendingTransactions = const [],
    this.syncedTransactions = const [],
    this.totalPending = 0,
    this.totalSynced = 0,
    this.totalFailed = 0,
    this.isConnected = true,
    this.errorMessage,
    this.lastSyncTime,
    this.progressPercentage = 0.0,
    this.isSyncing = false,
    this.retryCount = 0,
    this.lastSyncStatus,
  });

  SyncState copyWith({
    SyncSubState? subState,
    List<TransactionEntity>? pendingTransactions,
    List<TransactionEntity>? syncedTransactions,
    int? totalPending,
    int? totalSynced,
    int? totalFailed,
    bool? isConnected,
    String? errorMessage,
    DateTime? lastSyncTime,
    double? progressPercentage,
    bool? isSyncing,
    int? retryCount,
    SyncStatus? lastSyncStatus,
    bool clearError = false,
    bool clearLastSyncTime = false,
  }) {
    return SyncState(
      subState: subState ?? this.subState,
      pendingTransactions: pendingTransactions ?? this.pendingTransactions,
      syncedTransactions: syncedTransactions ?? this.syncedTransactions,
      totalPending: totalPending ?? this.totalPending,
      totalSynced: totalSynced ?? this.totalSynced,
      totalFailed: totalFailed ?? this.totalFailed,
      isConnected: isConnected ?? this.isConnected,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lastSyncTime: clearLastSyncTime ? null : (lastSyncTime ?? this.lastSyncTime),
      progressPercentage: progressPercentage ?? this.progressPercentage,
      isSyncing: isSyncing ?? this.isSyncing,
      retryCount: retryCount ?? this.retryCount,
      lastSyncStatus: lastSyncStatus ?? this.lastSyncStatus,
    );
  }

  bool get hasPendingTransactions => totalPending > 0;
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
  bool get canSync => isConnected && !isSyncing;
  bool get isInitial => subState == SyncSubState.initial;
  bool get isOffline => subState == SyncSubState.offline;
  bool get isSuccess => subState == SyncSubState.success;
  bool get isFailure => subState == SyncSubState.failure;

  String get statusMessage {
    switch (subState) {
      case SyncSubState.initial:
        return 'Sincronización no iniciada';
      case SyncSubState.loading:
        return 'Cargando transacciones pendientes...';
      case SyncSubState.syncing:
        return 'Sincronizando $totalSynced de $totalPending transacciones...';
      case SyncSubState.success:
        return 'Sincronización completada. $totalSynced transacciones sincronizadas.';
      case SyncSubState.failure:
        return errorMessage ?? 'Error en la sincronización';
      case SyncSubState.offline:
        return 'Sin conexión. Las transacciones se almacenarán localmente.';
      case SyncSubState.paused:
        return 'Sincronización pausada';
    }
  }

  @override
  List<Object?> get props => [
        subState,
        pendingTransactions,
        syncedTransactions,
        totalPending,
        totalSynced,
        totalFailed,
        isConnected,
        errorMessage,
        lastSyncTime,
        progressPercentage,
        isSyncing,
        retryCount,
        lastSyncStatus,
      ];
}

// === ARCHIVO: lib/presentation/blocs/sync/sync_bloc.dart ===
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:payment_app/domain/entities/entities.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app/domain/usecases/sync_transactions_usecase.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions_usecase.dart';
import 'package:payment_app/core/network/connectivity_service.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'sync_event.dart';
import 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final SyncTransactionsUseCase syncTransactionsUseCase;
  final GetPendingTransactionsUseCase getPendingTransactionsUseCase;
  final TransactionRepository transactionRepository;
  final ConnectivityService connectivityService;
  
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _periodicSyncTimer;
  static const int maxRetries = 3;
  static const Duration defaultSyncInterval = Duration(minutes: 5);

  SyncBloc({
    required this.syncTransactionsUseCase,
    required this.getPendingTransactionsUseCase,
    required this.transactionRepository,
    required this.connectivityService,
  }) : super(const SyncState()) {
    on<SyncStarted>(_onSyncStarted);
    on<SyncRequested>(_onSyncRequested);
    on<SyncCompleted>(_onSyncCompleted);
    on<SyncFailed>(_onSyncFailed);
    on<NetworkStatusChanged>(_onNetworkStatusChanged);
    on<RetrySyncRequested>(_onRetrySyncRequested);
    on<PendingTransactionsLoaded>(_onPendingTransactionsLoaded);
    on<SchedulePeriodicSync>(_onSchedulePeriodicSync);
    on<CancelPeriodicSync>(_onCancelPeriodicSync);
    on<ForceFullSync>(_onForceFullSync);
    on<SyncPaused>(_onSyncPaused);
    on<SyncResumed>(_onSyncResumed);

    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    _connectivitySubscription = connectivityService.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        final isConnected = connectivityService.isConnected(results);
        add(NetworkStatusChanged(isConnected: isConnected));
      },
    );
  }

  Future<void> _onSyncStarted(
    SyncStarted event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(
      subState: SyncSubState.loading,
      isSyncing: true,
      clearError: true,
    ));

    final connectivityResult = await connectivityService.checkConnectivity();
    final isConnected = connectivityService.isConnected(connectivityResult);

    if (!isConnected) {
      emit(state.copyWith(
        subState: SyncSubState.offline,
        isConnected: false,
        isSyncing: false,
      ));
      return;
    }

    add(const SyncRequested());
  }

  Future<void> _onSyncRequested(
    SyncRequested event,
    Emitter<SyncState> emit,
  ) async {
    if (state.isSyncing) {
      return;
    }

    emit(state.copyWith(
      subState: SyncSubState.syncing,
      isSyncing: true,
      clearError: true,
      progressPercentage: 0.0,
    ));

    final pendingResult = await getPendingTransactionsUseCase(const GetPendingTransactionsParams());
    
    await pendingResult.fold(
      (failure) async {
        emit(state.copyWith(
          subState: SyncSubState.failure,
          errorMessage: _mapFailureToMessage(failure),
          isSyncing: false,
        ));
      },
      (pendingTransactions) async {
        if (pendingTransactions.isEmpty) {
          emit(state.copyWith(
            subState: SyncSubState.success,
            totalPending: 0,
            totalSynced: 0,
            progressPercentage: 100.0,
            isSyncing: false,
            lastSyncTime: DateTime.now(),
            lastSyncStatus: SyncStatus.synced,
          ));
          return;
        }

        emit(state.copyWith(
          pendingTransactions: pendingTransactions,
          totalPending: pendingTransactions.length,
        ));

        final syncResult = await syncTransactionsUseCase(const SyncTransactionsParams());
        
        await syncResult.fold(
          (failure) async {
            emit(state.copyWith(
              subState: SyncSubState.failure,
              errorMessage: _mapFailureToMessage(failure),
              isSyncing: false,
            ));
          },
          (syncedTransactions) async {
            add(SyncCompleted(syncedTransactions: syncedTransactions));
          },
        );
      },
    );
  }

  Future<void> _onSyncCompleted(
    SyncCompleted event,
    Emitter<SyncState> emit,
  ) async {
    final totalTransactions = state.pendingTransactions.length;
    final syncedCount = event.syncedTransactions.length;
    final failedCount = totalTransactions - syncedCount;
    
    final updatedPending = state.pendingTransactions
        .where((t) => !event.syncedTransactions.any((s) => s.id == t.id))
        .toList();

    emit(state.copyWith(
      subState: SyncSubState.success,
      pendingTransactions: updatedPending,
      syncedTransactions: event.syncedTransactions,
      totalPending: updatedPending.length,
      totalSynced: syncedCount,
      totalFailed: failedCount,
      progressPercentage: 100.0,
      isSyncing: false,
      lastSyncTime: DateTime.now(),
      lastSyncStatus: SyncStatus.synced,
      retryCount: 0,
    ));
  }

  Future<void> _onSyncFailed(
    SyncFailed event,
    Emitter<SyncState> emit,
  ) async {
    final newRetryCount = state.retryCount + 1;
    
    if (newRetryCount < maxRetries) {
      emit(state.copyWith(
        subState: SyncSubState.syncing,
        errorMessage: event.errorMessage,
        retryCount: newRetryCount,
        totalFailed: event.failedCount,
      ));
      
      await Future.delayed(Duration(seconds: newRetryCount * 2));
      add(const RetrySyncRequested());
    } else {
      emit(state.copyWith(
        subState: SyncSubState.failure,
        errorMessage: 'Sincronización fallida después de $maxRetries intentos: ${event.errorMessage}',
        retryCount: newRetryCount,
        isSyncing: false,
      ));
    }
  }

  Future<void> _onNetworkStatusChanged(
    NetworkStatusChanged event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(isConnected: event.isConnected));

    if (event.isConnected && state.hasPendingTransactions && !state.isSyncing) {
      add(const SyncRequested());
    } else if (!event.isConnected) {
      emit(state.copyWith(subState: SyncSubState.offline));
    }
  }

  Future<void> _onRetrySyncRequested(
    RetrySyncRequested event,
    Emitter<SyncState> emit,
  ) async {
    if (!state.isConnected) {
      emit(state.copyWith(subState: SyncSubState.offline));
      return;
    }

    emit(state.copyWith(
      subState: SyncSubState.syncing,
      isSyncing: true,
      clearError: true,
    ));

    final syncResult = await syncTransactionsUseCase(const SyncTransactionsParams());
    
    await syncResult.fold(
      (failure) async {
        add(SyncFailed(
          errorMessage: _mapFailureToMessage(failure),
          failedCount: state.totalPending,
        ));
      },
      (syncedTransactions) async {
        add(SyncCompleted(syncedTransactions: syncedTransactions));
      },
    );
  }

  Future<void> _onPendingTransactionsLoaded(
    PendingTransactionsLoaded event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(
      pendingTransactions: event.pendingTransactions,
      totalPending: event.pendingTransactions.length,
    ));
  }

  void _onSchedulePeriodicSync(
    SchedulePeriodicSync event,
    Emitter<SyncState> emit,
  ) {
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = Timer.periodic(
      event.interval,
      (_) {
        if (state.isConnected && state.hasPendingTransactions) {
          add(const SyncRequested());
        }
      },
    );
  }

  void _onCancelPeriodicSync(
    CancelPeriodicSync event,
    Emitter<SyncState> emit,
  ) {
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = null;
  }

  Future<void> _onForceFullSync(
    ForceFullSync event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(
      pendingTransactions: [],
      syncedTransactions: [],
      totalPending: 0,
      totalSynced: 0,
      totalFailed: 0,
      retryCount: 0,
      clearError: true,
    ));

    add(const SyncStarted());
  }

  void _onSyncPaused(
    SyncPaused event,
    Emitter<SyncState> emit,
  ) {
    emit(state.copyWith(
      subState: SyncSubState.paused,
      isSyncing: false,
    ));
    _periodicSyncTimer?.cancel();
  }

  void _onSyncResumed(
    SyncResumed event,
    Emitter<SyncState> emit,
  ) {
    if (state.isConnected && state.hasPendingTransactions) {
      add(const SyncRequested());
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Error del servidor: ${failure.message}';
    } else if (failure is NetworkFailure) {
      return 'Error de conexión: ${failure.message}';
    } else if (failure is CacheFailure) {
      return 'Error de caché: ${failure.message}';
    } else if (failure is ValidationFailure) {
      return 'Error de validación: ${failure.message}';
    }
    return 'Error desconocido en la sincronización';
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _periodicSyncTimer?.cancel();
    return super.close();
  }
}

// === ARCHIVO: lib/presentation/screens/payment_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:payment_app/domain/entities/entities.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_event.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_state.dart';
import 'package:payment_app/presentation/blocs/sync/sync_bloc.dart';
import 'package:payment_app/presentation/blocs/sync/sync_state.dart';
import 'package:payment_app/presentation/widgets/transaction_form.dart';
import 'package:payment_app/presentation/widgets/sync_indicator.dart';
import 'package:payment_app/core/errors/failures.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  String _selectedCurrency = 'USD';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  void _submitTransaction() {
    if (!_formKey.currentState!.validate()) return;
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      _showError('El monto debe ser un número positivo');
      setState(() => _isSubmitting = false);
      return;
    }

    final recipientId = _recipientController.text.trim();
    if (recipientId.isEmpty) {
      _showError('El destinatario es requerido');
      setState(() => _isSubmitting = false);
      return;
    }

    final transaction = TransactionEntity(
      id: const Uuid().v4(),
      userId: 'current_user_id',
      amount: amount,
      currency: _selectedCurrency,
      recipientId: recipientId,
      createdAt: DateTime.now(),
      syncStatus: SyncStatus.pending,
      retryCount: 0,
    );

    context.read<TransactionBloc>().add(CreateTransactionEvent(transaction));
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Cerrar',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _resetForm() {
    _amountController.clear();
    _recipientController.clear();
    setState(() {
      _selectedCurrency = 'USD';
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Pago'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          BlocBuilder<SyncBloc, SyncState>(
            builder: (context, state) {
              return const SyncIndicator();
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if (state is TransactionCreated) {
                _showSuccess(
                  'Transacción creada exitosamente. '
                  'Se sincronizará cuando haya conexión.',
                );
                _resetForm();
              } else if (state is TransactionError) {
                setState(() => _isSubmitting = false);
                _showError(_mapFailureToMessage(state.failure));
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.payment,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Detalles del Pago',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TransactionForm(
                          amountController: _amountController,
                          recipientController: _recipientController,
                          selectedCurrency: _selectedCurrency,
                          onCurrencyChanged: (value) {
                            setState(() => _selectedCurrency = value ?? 'USD');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    final isLoading = state is TransactionLoading || _isSubmitting;
                    return FilledButton.icon(
                      onPressed: isLoading ? null : _submitTransaction,
                      icon: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.send),
                      label: Text(
                        isLoading ? 'Procesando...' : 'Enviar Pago',
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<SyncBloc, SyncState>(
                  builder: (context, state) {
                    if (state is SyncInProgress) {
                      return Card(
                        color: Colors.blue.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Sincronizando ${state.pendingCount} transacciones pendientes...',
                                  style: TextStyle(color: Colors.blue.shade700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 24),
                _buildOfflineInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOfflineInfo() {
    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Si no hay conexión, la transacción se guardará localmente '
                'y se sincronizará automáticamente cuando se restablezca la conexión.',
                style: TextStyle(
                  color: Colors.orange.shade900,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Error del servidor: ${failure.message}';
    } else if (failure is CacheFailure) {
      return 'Error de almacenamiento local';
    } else if (failure is NetworkFailure) {
      return 'Sin conexión. La transacción se guardará localmente.';
    } else if (failure is ValidationFailure) {
      return 'Validación fallida: ${failure.message}';
    }
    return 'Error desconocido';
  }
}

// === ARCHIVO: lib/presentation/screens/transactions_history_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:payment_app/domain/entities/entities.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_event.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_state.dart';
import 'package:payment_app/presentation/blocs/sync/sync_bloc.dart';
import 'package:payment_app/presentation/blocs/sync/sync_event.dart';
import 'package:payment_app/presentation/blocs/sync/sync_state.dart';
import 'package:payment_app/presentation/widgets/transaction_card.dart';
import 'package:payment_app/presentation/widgets/sync_indicator.dart';

class TransactionsHistoryScreen extends StatefulWidget {
  const TransactionsHistoryScreen({super.key});

  @override
  State<TransactionsHistoryScreen> createState() => _TransactionsHistoryScreenState();
}

class _TransactionsHistoryScreenState extends State<TransactionsHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadTransactions() {
    context.read<TransactionBloc>().add(LoadTransactionsEvent());
  }

  Future<void> _onRefresh() async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    
    context.read<TransactionBloc>().add(LoadTransactionsEvent());
    context.read<SyncBloc>().add(SyncTransactionsEvent());
    
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _isRefreshing = false);
    }
  }

  void _deleteTransaction(String transactionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text(
          '¿Está seguro de que desea eliminar esta transacción? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<TransactionBloc>().add(DeleteTransactionEvent(transactionId));
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Transacciones'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          BlocBuilder<SyncBloc, SyncState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SyncIndicator(),
                  if (state is SyncInProgress)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '${state.pendingCount}',
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sincronizar ahora',
            onPressed: () {
              context.read<SyncBloc>().add(SyncTransactionsEvent());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSyncStatusBar(),
          Expanded(
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is TransactionError) {
                  return _buildErrorState(state.message);
                }

                if (state is TransactionsLoaded) {
                  if (state.transactions.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildTransactionsList(state.transactions);
                }

                return _buildEmptyState();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncStatusBar() {
    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, state) {
        if (state is SyncInProgress) {
          return Container(
            color: Colors.blue.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Sincronizando ${state.pendingCount} transacciones con el servidor...',
                    style: TextStyle(color: Colors.blue.shade700),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is SyncCompleted) {
          return Container(
            color: Colors.green.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade700, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Sincronización completada. ${state.syncedCount} transacciones enviadas.',
                  style: TextStyle(color: Colors.green.shade700),
                ),
              ],
            ),
          );
        }

        if (state is SyncError) {
          return Container(
            color: Colors.red.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade700, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Error de sincronización: ${state.errorMessage}',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTransactionsList(List<TransactionEntity> transactions) {
    final sortedTransactions = List<TransactionEntity>.from(transactions)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final groupedByDate = _groupTransactionsByDate(sortedTransactions);

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: groupedByDate.length,
        itemBuilder: (context, index) {
          final dateKey = groupedByDate.keys.elementAt(index);
          final dayTransactions = groupedByDate[dateKey]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Text(
                  dateKey,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...dayTransactions.map((transaction) => TransactionCard(
                transaction: transaction,
                onDelete: () => _deleteTransaction(transaction.id),
              )),
            ],
          );
        },
      ),
    );
  }

  Map<String, List<TransactionEntity>> _groupTransactionsByDate(
    List<TransactionEntity> transactions,
  ) {
    final Map<String, List<TransactionEntity>> grouped = {};
    final dateFormat = DateFormat('EEEE, d MMMM yyyy', 'es_ES');

    for (final transaction in transactions) {
      final dateKey = dateFormat.format(transaction.createdAt);
      grouped.putIfAbsent(dateKey, () => []).add(transaction);
    }

    return grouped;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No hay transacciones',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Las transacciones que realices aparecerán aquí',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Error al cargar transacciones',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _loadTransactions,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}

// === ARCHIVO: lib/presentation/widgets/transaction_form.dart ===
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/domain/entities/entities.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_event.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_state.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final String userId;
  final Function(TransactionEntity)? onTransactionCreated;

  const TransactionForm({
    super.key,
    required this.userId,
    this.onTransactionCreated,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  final _currencyController = TextEditingController(text: 'USD');
  bool _isSubmitting = false;

  final List<String> _availableCurrencies = ['USD', 'EUR', 'GBP', 'MXN', 'JPY'];

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final amount = double.tryParse(_amountController.text.trim());
    final recipientId = _recipientController.text.trim();
    final currency = _currencyController.text.trim();

    if (amount == null || amount <= 0) {
      _showErrorSnackBar('El monto debe ser un número positivo');
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    final transaction = TransactionEntity(
      id: const Uuid().v4(),
      userId: widget.userId,
      amount: amount,
      currency: currency,
      recipientId: recipientId,
      createdAt: DateTime.now(),
      updatedAt: null,
      syncStatus: SyncStatus.pending,
      retryCount: 0,
      serverId: null,
      errorMessage: null,
    );

    context.read<TransactionBloc>().add(CreateTransactionEvent(transaction));
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _resetForm() {
    _amountController.clear();
    _recipientController.clear();
    _currencyController.text = 'USD';
    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionCreated) {
          _showSuccessSnackBar('Transacción creada correctamente');
          _resetForm();
          widget.onTransactionCreated?.call(state.transaction);
        } else if (state is TransactionError) {
          _showErrorSnackBar(state.message);
          setState(() {
            _isSubmitting = false;
          });
        } else if (state is TransactionLoading) {
          setState(() {
            _isSubmitting = true;
          });
        }
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nueva Transacción',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Monto',
                    hintText: 'Ingrese el monto a transferir',
                    prefixIcon: const Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingrese un monto';
                    }
                    final amount = double.tryParse(value.trim());
                    if (amount == null || amount <= 0) {
                      return 'El monto debe ser mayor a cero';
                    }
                    if (amount > 1000000) {
                      return 'El monto excede el límite permitido';
                    }
                    return null;
                  },
                  enabled: !_isSubmitting,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _currencyController.text,
                  decoration: InputDecoration(
                    labelText: 'Moneda',
                    prefixIcon: const Icon(Icons.currency_exchange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  items: _availableCurrencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: _isSubmitting
                      ? null
                      : (value) {
                          if (value != null) {
                            _currencyController.text = value;
                          }
                        },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _recipientController,
                  decoration: InputDecoration(
                    labelText: 'Destinatario',
                    hintText: 'Ingrese el ID del beneficiario',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingrese el destinatario';
                    }
                    if (value.trim().length < 3) {
                      return 'El ID del destinatario debe tener al menos 3 caracteres';
                    }
                    if (value.trim() == widget.userId) {
                      return 'No puede transferirse a sí mismo';
                    }
                    return null;
                  },
                  enabled: !_isSubmitting,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send),
                  label: Text(
                    _isSubmitting ? 'Procesando...' : 'Enviar Transacción',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionError) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber, color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                state.message,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// === ARCHIVO: lib/presentation/widgets/transaction_card.dart ===
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payment_app/domain/entities/entities.dart';

class TransactionCard extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback? onTap;
  final VoidCallback? onRetry;
  final VoidCallback? onDelete;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
    this.onRetry,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');
    final currencyFormat = NumberFormat.currency(
      symbol: transaction.currency == 'USD' ? '\$' : transaction.currency,
      decimalDigits: 2,
    );

    return Card(
      elevation: _calculateElevation(transaction.syncStatus),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getStatusColor(transaction.syncStatus).withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaction ID',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatTransactionId(transaction.id),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(context),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoColumn(
                    context,
                    'Amount',
                    currencyFormat.format(transaction.amount),
                    isAmount: true,
                  ),
                  _buildInfoColumn(
                    context,
                    'Recipient',
                    _formatRecipientId(transaction.recipientId),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoColumn(
                    context,
                    'Created',
                    dateFormat.format(transaction.createdAt),
                  ),
                  if (transaction.updatedAt != null)
                    _buildInfoColumn(
                      context,
                      'Updated',
                      dateFormat.format(transaction.updatedAt!),
                    ),
                ],
              ),
              if (_shouldShowErrorState(transaction)) ...[
                const SizedBox(height: 12),
                _buildErrorSection(context),
              ],
              if (_shouldShowActions(transaction)) ...[
                const SizedBox(height: 12),
                _buildActionButtons(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    final color = _getStatusColor(transaction.syncStatus);
    final icon = _getStatusIcon(transaction.syncStatus);
    final label = _getStatusLabel(transaction.syncStatus);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(
    BuildContext context,
    String label,
    String value, {
    bool isAmount = false,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: isAmount
              ? theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                )
              : theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
        ),
      ],
    );
  }

  Widget _buildErrorSection(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                size: 16,
                color: theme.colorScheme.error,
              ),
              const SizedBox(width: 6),
              Text(
                'Error Details',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            transaction.errorMessage ?? 'Unknown error occurred',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onErrorContainer,
            ),
          ),
          if (transaction.retryCount > 0) ...[
            const SizedBox(height: 8),
            Text(
              'Retry attempts: ${transaction.retryCount}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (transaction.syncStatus == SyncStatus.failed && onRetry != null)
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Retry'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        if (transaction.syncStatus == SyncStatus.pending && onDelete != null)
          TextButton.icon(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text('Delete'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
          ),
      ],
    );
  }

  double _calculateElevation(SyncStatus status) {
    switch (status) {
      case SyncStatus.synced:
        return 1.0;
      case SyncStatus.pending:
        return 2.0;
      case SyncStatus.syncing:
        return 3.0;
      case SyncStatus.failed:
        return 4.0;
    }
  }

  Color _getStatusColor(SyncStatus status) {
    switch (status) {
      case SyncStatus.synced:
        return Colors.green;
      case SyncStatus.pending:
        return Colors.orange;
      case SyncStatus.syncing:
        return Colors.blue;
      case SyncStatus.failed:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(SyncStatus status) {
    switch (status) {
      case SyncStatus.synced:
        return Icons.check_circle;
      case SyncStatus.pending:
        return Icons.schedule;
      case SyncStatus.syncing:
        return Icons.sync;
      case SyncStatus.failed:
        return Icons.error;
    }
  }

  String _getStatusLabel(SyncStatus status) {
    switch (status) {
      case SyncStatus.synced:
        return 'Synced';
      case SyncStatus.pending:
        return 'Pending';
      case SyncStatus.syncing:
        return 'Syncing';
      case SyncStatus.failed:
        return 'Failed';
    }
  }

  String _formatTransactionId(String id) {
    if (id.length <= 8) return id;
    return '${id.substring(0, 8)}...';
  }

  String _formatRecipientId(String recipientId) {
    if (recipientId.length <= 12) return recipientId;
    return '${recipientId.substring(0, 12)}...';
  }

  bool _shouldShowErrorState(TransactionEntity transaction) {
    return transaction.syncStatus == SyncStatus.failed &&
        (transaction.errorMessage != null || transaction.retryCount > 0);
  }

  bool _shouldShowActions(TransactionEntity transaction) {
    return (transaction.syncStatus == SyncStatus.failed && onRetry != null) ||
        (transaction.syncStatus == SyncStatus.pending && onDelete != null);
  }
}

// === ARCHIVO: lib/presentation/widgets/sync_indicator.dart ===
import 'package:flutter/material.dart';
import 'package:payment_app/domain/entities/entities.dart';

class SyncIndicator extends StatefulWidget {
  final SyncStatus status;
  final int pendingCount;
  final int failedCount;
  final VoidCallback? onSyncPressed;
  final VoidCallback? onRetryPressed;
  final bool showDetails;

  const SyncIndicator({
    super.key,
    required this.status,
    this.pendingCount = 0,
    this.failedCount = 0,
    this.onSyncPressed,
    this.onRetryPressed,
    this.showDetails = true,
  });

  @override
  State<SyncIndicator> createState() => _SyncIndicatorState();
}

class _SyncIndicatorState extends State<SyncIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.status == SyncStatus.syncing) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(SyncIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status == SyncStatus.syncing &&
        oldWidget.status != SyncStatus.syncing) {
      _animationController.repeat(reverse: true);
    } else if (widget.status != SyncStatus.syncing &&
        oldWidget.status == SyncStatus.syncing) {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor();
    final statusConfig = _getStatusConfig();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildAnimatedIcon(statusConfig.icon, statusColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statusConfig.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      statusConfig.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.status == SyncStatus.pending &&
                  widget.onSyncPressed != null)
                _buildActionButton(
                  icon: Icons.sync,
                  label: 'Sync Now',
                  onPressed: widget.onSyncPressed,
                  color: theme.colorScheme.primary,
                ),
              if (widget.status == SyncStatus.failed &&
                  widget.onRetryPressed != null)
                _buildActionButton(
                  icon: Icons.refresh,
                  label: 'Retry',
                  onPressed: widget.onRetryPressed,
                  color: theme.colorScheme.error,
                ),
            ],
          ),
          if (widget.showDetails && _shouldShowDetails()) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            _buildDetailsSection(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildAnimatedIcon(IconData icon, Color color) {
    if (widget.status == SyncStatus.syncing) {
      return AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return Material(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsSection(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailItem(
          context,
          icon: Icons.schedule,
          label: 'Pending',
          count: widget.pendingCount,
          color: Colors.orange,
        ),
        _buildDetailItem(
          context,
          icon: Icons.error_outline,
          label: 'Failed',
          count: widget.failedCount,
          color: Colors.red,
        ),
        _buildDetailItem(
          context,
          icon: Icons.check_circle_outline,
          label: 'Synced',
          count: _calculateSyncedCount(),
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          count.toString(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (widget.status) {
      case SyncStatus.synced:
        return Colors.green;
      case SyncStatus.pending:
        return Colors.orange;
      case SyncStatus.syncing:
        return Colors.blue;
      case SyncStatus.failed:
        return Colors.red;
    }
  }

  _SyncStatusConfig _getStatusConfig() {
    switch (widget.status) {
      case SyncStatus.synced:
        return _SyncStatusConfig(
          title: 'All Synced',
          subtitle: 'All transactions are up to date',
          icon: Icons.cloud_done,
        );
      case SyncStatus.pending:
        return _SyncStatusConfig(
          title: 'Pending Sync',
          subtitle: '${widget.pendingCount} transaction(s) waiting to sync',
          icon: Icons.cloud_upload_outlined,
        );
      case SyncStatus.syncing:
        return _SyncStatusConfig(
          title: 'Syncing...',
          subtitle: 'Uploading pending transactions',
          icon: Icons.sync,
        );
      case SyncStatus.failed:
        return _SyncStatusConfig(
          title: 'Sync Failed',
          subtitle: '${widget.failedCount} transaction(s) failed to sync',
          icon: Icons.cloud_off,
        );
    }
  }

  bool _shouldShowDetails() {
    return widget.pendingCount > 0 ||
        widget.failedCount > 0 ||
        widget.status == SyncStatus.synced;
  }

  int _calculateSyncedCount() {
    if (widget.pendingCount == 0 && widget.failedCount == 0) {
      return 0;
    }
    return (widget.pendingCount + widget.failedCount) > 0
        ? (10 - widget.pendingCount - widget.failedCount).clamp(0, 10)
        : 0;
  }
}

class _SyncStatusConfig {
  final String title;
  final String subtitle;
  final IconData icon;

  _SyncStatusConfig({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

// === ARCHIVO: test/unit/transaction_entity_test.dart ===
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

// === ARCHIVO: test/unit/transaction_repository_test.dart ===
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

// === ARCHIVO: test/integration/sync_flow_test.dart ===
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

// === ARCHIVO: lib/core/network/connectivity_service.dart ===
package payment_app.core.network;

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService implements NetworkInfo {
  final Connectivity _connectivity;
  final StreamController<bool> _connectionStatusController;
  bool _isConnected;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity(),
        _connectionStatusController = StreamController<bool>.broadcast(),
        _isConnected = false;

  @override
  bool get isConnected => _isConnected;

  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  Future<void> initialize() async {
    await _checkConnectionStatus();
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _handleConnectivityChange,
      onError: (error) {
        _updateConnectionStatus([]);
      },
    );
  }

  Future<void> _checkConnectionStatus() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _handleConnectivityChange(results);
    } catch (e) {
      _isConnected = false;
      _connectionStatusController.add(false);
    }
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    _isConnected = _hasActiveConnection(results);
    _connectionStatusController.add(_isConnected);
  }

  bool _hasActiveConnection(List<ConnectivityResult> results) {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return false;
    }
    return results.any((result) =>
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet);
  }

  @override
  Future<bool> get isConnectedWifi async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.wifi);
  }

  @override
  Future<bool> get isConnectedMobile async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.mobile);
  }

  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    await _connectionStatusController.close();
  }
}

// === ARCHIVO: lib/core/network/network_info.dart ===
package payment_app.core.network;

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<bool> get isConnectedWifi;
  Future<bool> get isConnectedMobile;
}

class NetworkInfoImpl implements NetworkInfo {
  final ConnectivityService _connectivityService;

  NetworkInfoImpl(this._connectivityService);

  @override
  Future<bool> get isConnected async {
    await _connectivityService.initialize();
    return _connectivityService.isConnected;
  }

  @override
  Future<bool> get isConnectedWifi async {
    return _connectivityService.isConnectedWifi;
  }

  @override
  Future<bool> get isConnectedMobile async {
    return _connectivityService.isConnectedMobile;
  }
}

// === ARCHIVO: lib/core/errors/failures.dart ===
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
```
