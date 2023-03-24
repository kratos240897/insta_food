import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:insta_food/core/base/service_locator.dart';

import '../../features/home/domain/use_cases/execute_order.dart';
import '../constants/enum/network_state.dart';
import '../constants/enum/snackbar_status.dart';
import '../init/network/connection_aware.dart';
import '../init/utils/utils.dart';

abstract class BaseController extends GetxController with ConnectionAware {
  final isNetworkAvailable = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isNetworkAvailable.value = await getIsInternetAvailable();
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        networkState = NetworkState.connected;
        if (isNetworkAvailable.value != true) {
          onNetworkConnected();
        }
      } else if (result == ConnectivityResult.none) {
        networkState = NetworkState.disconnected;
        onNetworkDisconnected();
      }
    });
  }

  Future<bool> getIsInternetAvailable() async {
    final value = await Connectivity().checkConnectivity();
    if (value == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void onNetworkConnected() {
    isNetworkAvailable.value = true;
    Utils().showSnackBar(
        'Internet Connection', 'Back Online', SnackBarStatus.success);
    serviceLocator<ExecuteOrder>().executeOrders().then((value) => Utils()
        .showSnackBar(
            'Success', 'Pending orders executed', SnackBarStatus.info));
  }

  @override
  void onNetworkDisconnected() {
    isNetworkAvailable.value = false;
    Utils().showSnackBar(
        'Internet Connection', 'You\'re offline', SnackBarStatus.failure);
  }
}
