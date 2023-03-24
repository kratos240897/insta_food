import 'dart:async';

import '../../constants/enum/network_state.dart';

abstract class ConnectionAware {
  NetworkState? networkState;
  StreamSubscription? connectivitySubscription;

  void onNetworkConnected();
  void onNetworkDisconnected();
}
