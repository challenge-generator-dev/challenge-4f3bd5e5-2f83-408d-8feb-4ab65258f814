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