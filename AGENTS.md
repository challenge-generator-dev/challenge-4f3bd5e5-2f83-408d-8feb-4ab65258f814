# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Implementación de persistencia local y sincronización en modo offline para una aplicación de pagos**.

| | |
|---|---|
| Tema | persistencia local y modo offline (reg 1109) |
| Nivel | senior-l2 |
| Chapter | Móvil |
| Especialidad | Flutter |
| Stack | Dart 3.6 / Flutter 3.27 |
| Patron arquitectonico | clean architecture |
| Tiempo estimado | 2 semanas |

## Receta del stack

Esqueleto obligatorio:

- `pubspec.yaml en la raiz`
- `lib/main.dart con runApp`
- `lib/domain con entidades y repositorios abstractos`
- `lib/data con las implementaciones y el cliente Dio`
- `lib/presentation con screens y blocs/notifiers`

Dependencias:

- flutter_bloc 8.1.6
- equatable 2.0.5
- dartz 0.10.1
- get_it 7.7.0
- sqflite 2.3.3
- path 1.9.0
- connectivity_plus 6.0.5
- http 1.2.2
- uuid 4.4.2
- intl 0.19.0
- bloc_test 9.1.7
- mocktail 1.0.4

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `flutter pub get && flutter analyze` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `flutter pub get && flutter analyze` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Diseño del modelo de persistencia local**: Modelo de datos para persistencia local y reglas de sincronización.
- **Fase 2 — Implementación de la persistencia local**: Implementación de la funcionalidad de persistencia local para transacciones.
- **Fase 3 — Sincronización de datos con el servidor**: Implementación de la funcionalidad de sincronización de datos con el servidor.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `lib/data/datasources/local/database_helper.dart` — El topic pide persistencia: este archivo es el ejercicio.
- [ ] `lib/data/repositories/transaction_repository_impl.dart` — El topic pide persistencia: este archivo es el ejercicio.

## Lo que falta y tenes que completar

### 1. Referencias colgando (14)

Salieron de un analisis estatico del codigo que SI esta en el repo. Cada una rompe la compilacion:

- [ ] `lib/presentation/blocs/sync/sync_bloc.dart` — `ConnectivityService.isConnected`
      Se invoca `isConnected` sobre `ConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/presentation/blocs/sync/sync_bloc.dart` — `ConnectivityService.checkConnectivity`
      Se invoca `checkConnectivity` sobre `ConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.createTransaction`
      Se invoca `createTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.getPendingTransactions`
      Se invoca `getPendingTransactions` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.updateTransaction`
      Se invoca `updateTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/transaction_repository_test.dart` — `MockRemoteDataSource.syncTransaction`
      Se invoca `syncTransaction` sobre `MockRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.getAllTransactions`
      Se invoca `getAllTransactions` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/unit/transaction_repository_test.dart` — `MockLocalDataSource.deleteTransaction`
      Se invoca `deleteTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/integration/sync_flow_test.dart` — `MockConnectivityService.isConnected`
      Se invoca `isConnected` sobre `MockConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/integration/sync_flow_test.dart` — `MockLocalDataSource.createTransaction`
      Se invoca `createTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/integration/sync_flow_test.dart` — `MockLocalDataSource.getPendingTransactions`
      Se invoca `getPendingTransactions` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/integration/sync_flow_test.dart` — `MockLocalDataSource.updateTransaction`
      Se invoca `updateTransaction` sobre `MockLocalDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/integration/sync_flow_test.dart` — `MockRemoteDataSource.syncTransaction`
      Se invoca `syncTransaction` sobre `MockRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `test/integration/sync_flow_test.dart` — `MockConnectivityService.onConnectivityChanged`
      Se invoca `onConnectivityChanged` sobre `MockConnectivityService`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Presentes (33)

- `pubspec.yaml`
- `lib/main.dart`
- `lib/domain/entities/transaction_entity.dart`
- `lib/domain/entities/sync_status.dart`
- `lib/domain/repositories/transaction_repository.dart`
- `lib/domain/usecases/create_transaction_usecase.dart`
- `lib/domain/usecases/get_pending_transactions_usecase.dart`
- `lib/domain/usecases/sync_transactions_usecase.dart`
- `lib/data/models/transaction_model.dart`
- `lib/data/datasources/local/database_helper.dart`
- `lib/data/datasources/local/transaction_local_datasource.dart`
- `lib/data/datasources/remote/transaction_remote_datasource.dart`
- `lib/data/repositories/transaction_repository_impl.dart`
- `lib/core/errors/exceptions.dart`
- `lib/core/constants/app_constants.dart`
- `android/app/src/main/AndroidManifest.xml`
- `lib/presentation/blocs/transaction/transaction_event.dart`
- `lib/presentation/blocs/transaction/transaction_state.dart`
- `lib/presentation/blocs/transaction/transaction_bloc.dart`
- `lib/presentation/blocs/sync/sync_event.dart`
- `lib/presentation/blocs/sync/sync_state.dart`
- `lib/presentation/blocs/sync/sync_bloc.dart`
- `lib/presentation/screens/payment_screen.dart`
- `lib/presentation/screens/transactions_history_screen.dart`
- `lib/presentation/widgets/transaction_form.dart`
- `lib/presentation/widgets/transaction_card.dart`
- `lib/presentation/widgets/sync_indicator.dart`
- `test/unit/transaction_entity_test.dart`
- `test/unit/transaction_repository_test.dart`
- `test/integration/sync_flow_test.dart`
- `lib/core/network/connectivity_service.dart`
- `lib/core/network/network_info.dart`
- `lib/core/errors/failures.dart`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `lib/domain/entities`
- `lib/domain/repositories`
- `lib/domain/usecases`
- `lib/data/models`
- `lib/data/datasources/local`
- `lib/data/datasources/remote`
- `lib/data/repositories`
- `lib/presentation/screens`
- `lib/presentation/blocs`
- `lib/presentation/widgets`
- `lib/core/network`
- `lib/core/errors`
- `lib/core/constants`

## Verificacion

```bash
flutter pub get && flutter analyze
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **clean architecture**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior
- Brecha que el reto ataca: Maneja estado y flujos asincronicos con persistencia local y sincronizacion posterior
- Mision: Soportar operacion sin conexion en la app de pagos

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
