import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConnectivityService {
  ConnectivityService() {
    _checkInitialConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  final Connectivity _connectivity = Connectivity();
  final ValueNotifier<bool> isOnline = ValueNotifier<bool>(true);

  // StreamController for blink events when user tries to call API while offline
  final StreamController<void> _blinkController =
      StreamController<void>.broadcast();
  Stream<void> get onBlinkTriggered => _blinkController.stream;

  Future<void> _checkInitialConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // connectivity_plus 6.0+ returns a list. If any is not none, we are "online"
    isOnline.value = results.any(
      (element) => element != ConnectivityResult.none,
    );
  }

  void triggerBlink() {
    _blinkController.add(null);
  }

  void dispose() {
    _blinkController.close();
  }
}
