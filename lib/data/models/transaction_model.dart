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