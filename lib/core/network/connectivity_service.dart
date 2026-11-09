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