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