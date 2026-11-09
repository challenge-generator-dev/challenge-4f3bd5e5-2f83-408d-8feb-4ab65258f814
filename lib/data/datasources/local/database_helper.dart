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