import 'package:get/get.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/services/storage_service.dart';

class SplashController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(milliseconds: 1400));

    if (_storageService.isLoggedIn) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else if (_storageService.isOnboardingCompleted()) {
      Get.offAllNamed(AppRoutes.welcome);
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
