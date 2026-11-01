import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { online, offline }

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;

  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  final StreamController<bool> _connectivityController =
      StreamController<bool>.broadcast();

  bool _isConnected = true;

  NetworkService._internal({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity() {
    _init();
  }

  /// Constructor visible para pruebas o inyección de dependencias
  NetworkService.withCustomConnectivity(Connectivity connectivity)
      : _connectivity = connectivity {
    _init();
  }

  void _init() {
    // Escucha cambios de conectividad en tiempo real
    _subscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
    checkConnection();
  }

  /// Verifica el estado de conexión actual
  Future<bool> checkConnection() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateStatus(results);
      return _isConnected;
    } catch (_) {
      _isConnected = false;
      _connectivityController.add(false);
      return false;
    }
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final hasConnection =
        results.isNotEmpty && results.any((r) => r != ConnectivityResult.none);

    if (_isConnected != hasConnection || !_connectivityController.hasListener) {
      _isConnected = hasConnection;
      _connectivityController.add(_isConnected);
    }
  }

  /// Indica si el dispositivo cuenta con conexión a internet actualmente
  bool get isConnected => _isConnected;

  /// Stream que emite true si hay conexión y false si está desconectado
  Stream<bool> get isConnectedStream => _connectivityController.stream;

  /// Permite simular o forzar un estado en pruebas o depuración
  void emitStatusForTesting(bool connected) {
    _isConnected = connected;
    _connectivityController.add(connected);
  }

  void dispose() {
    _subscription?.cancel();
    _connectivityController.close();
  }
}

