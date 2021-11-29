import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get streamIsConnected;
  Future<ConnectivityResult> checkConnectivity();

  Future<void> init();
}

class NetworkInfo implements INetworkInfo {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult result = ConnectivityResult.none;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final StreamController<bool> _streamController = StreamController.broadcast();

  @override
  Future<void> init() async {
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }

    _updateConnectionStatus(result);
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _streamController.close();
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    this.result = result;
    _streamController.add(!(result == ConnectivityResult.none));
  }

  @override
  Future<ConnectivityResult> checkConnectivity() async {
    result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
    return result;
  }

  @override
  Future<bool> get isConnected async => result != ConnectivityResult.none;

  @override
  Stream<bool> get streamIsConnected => _streamController.stream;
}
