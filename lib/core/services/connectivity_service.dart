import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isOnline = true.obs;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  Future<ConnectivityService> init() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);

    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    return this;
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none) || results.isEmpty) {
      isOnline.value = false;
    } else {
      isOnline.value = true;
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
