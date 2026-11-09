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