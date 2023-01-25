import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:connectivity/connectivity.dart';

enum NetworkStatus {
  notDetermined,
  on,
  off,
}

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  NetworkDetectorNotifier() : super(NetworkStatus.notDetermined) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      NetworkStatus newState;
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = NetworkStatus.on;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.off;
          break;
      }

      if (newState != state) {
        state = newState;
      }
    });
  }
}
