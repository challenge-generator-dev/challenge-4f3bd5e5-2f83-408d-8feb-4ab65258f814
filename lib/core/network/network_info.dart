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