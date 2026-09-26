import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routing/app_routes.dart';
import '../theme/app_colors.dart';

class ConnectivityService extends GetxService {
  static ConnectivityService get to => Get.find<ConnectivityService>();

  final Connectivity _connectivity = Connectivity();
  final RxBool isOnline = true.obs;
  final RxBool isCheckingManual = false.obs;

  String? previousRoute;
  Timer? _redirectTimer;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  Future<ConnectivityService> init() async {
    final results = await _connectivity.checkConnectivity();
    final connected = await _verifyActualConnection(results);
    isOnline.value = connected;

    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      final hasNet = await _verifyActualConnection(results);
      _handleConnectivityUpdate(hasNet);
    });

    return this;
  }

  Future<bool> _verifyActualConnection(List<ConnectivityResult> results) async {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return false;
    }
    try {
      final lookup = await InternetAddress.lookup('google.com').timeout(
        const Duration(seconds: 3),
      );
      return lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _handleConnectivityUpdate(bool hasConnection) {
    if (!hasConnection) {
      if (isOnline.value) {
        isOnline.value = false;
        final current = Get.currentRoute;
        if (current.isNotEmpty && current != AppRoutes.noInternet) {
          previousRoute = current;
        }

        _showOfflineSnackbar();

        _redirectTimer?.cancel();
        _redirectTimer = Timer(const Duration(seconds: 10), () {
          if (!isOnline.value) {
            _dismissOfflineSnackbar();
            if (Get.currentRoute != AppRoutes.noInternet) {
              Get.toNamed(AppRoutes.noInternet);
            }
          }
        });
      }
    } else {
      if (!isOnline.value) {
        isOnline.value = true;
        _redirectTimer?.cancel();
        _dismissOfflineSnackbar();

        if (Get.currentRoute == AppRoutes.noInternet) {
          if (previousRoute != null &&
              previousRoute!.isNotEmpty &&
              previousRoute != AppRoutes.noInternet) {
            Get.offAllNamed(previousRoute!);
          } else {
            Get.offAllNamed(AppRoutes.dashboard);
          }
        }

        _showOnlineSnackbar();
      }
    }
  }

  void _showOfflineSnackbar() {
    _dismissOfflineSnackbar();

    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 16,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 10),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      padding: EdgeInsets.zero,
      messageText: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF141418),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2A2A34), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF2B161A),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.wifi_off_rounded,
                  color: Color(0xFFE56A75),
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No Internet Connection',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Attempting to reconnect...',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9E9EA8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.lavenderLight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOnlineSnackbar() {
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 16,
      backgroundColor: Colors.transparent,
      duration: const Duration(milliseconds: 2500),
      forwardAnimationCurve: Curves.easeOutBack,
      padding: EdgeInsets.zero,
      messageText: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF101813),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E3A26), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF163320),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.wifi_rounded,
                  color: Color(0xFF46A67A),
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Back Online',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Your connection has been restored.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA5B8AC),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFF1C452B),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Color(0xFF55B887),
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dismissOfflineSnackbar() {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
  }

  Future<void> checkConnectionManual() async {
    isCheckingManual.value = true;
    final results = await _connectivity.checkConnectivity();
    final connected = await _verifyActualConnection(results);
    isCheckingManual.value = false;

    if (connected) {
      _handleConnectivityUpdate(true);
    } else {
      Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 14,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 2),
        padding: EdgeInsets.zero,
        messageText: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF141418),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF2A2A34), width: 1),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: Color(0xFFE56A75), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Still offline. Please check your network connection.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void onClose() {
    _redirectTimer?.cancel();
    _subscription.cancel();
    super.onClose();
  }
}
