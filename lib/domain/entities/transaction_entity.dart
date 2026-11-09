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