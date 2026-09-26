import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/services/storage_service.dart';
import '../models/onboarding_item.dart';

class OnboardingController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingItem> items = const [
    OnboardingItem(
      title: 'Master Deep Focus',
      subtitle: 'Distraction-free timers and ambient soundscapes.',
      tag: 'Deep Focus',
      imageAsset: 'assets/images/onb1.png',
      icon: Iconsax.timer_1_copy,
    ),
    OnboardingItem(
      title: 'Block Addictive Feeds',
      subtitle: 'Mindful interventions to end endless scrolling.',
      tag: 'App Shield',
      imageAsset: 'assets/images/onb2.png',
      icon: Iconsax.shield_cross_copy,
    ),
    OnboardingItem(
      title: 'Build Lasting Habits',
      subtitle: 'Track daily consistency and protect your streaks.',
      tag: 'Habit Mastery',
      imageAsset: 'assets/images/onb3.png',
      icon: Iconsax.chart_square_copy,
    ),
    OnboardingItem(
      title: 'AI Insights & Live Rooms',
      subtitle: 'Smart focus rhythms and live accountability rooms.',
      tag: 'Multiplayer OS',
      imageAsset: 'assets/images/onb4.png',
      icon: Iconsax.people_copy,
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    } else {
      goToRegister();
    }
  }

  Future<void> goToLogin() async {
    await _storageService.setOnboardingCompleted(true);
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> goToRegister() async {
    await _storageService.setOnboardingCompleted(true);
    Get.offAllNamed(AppRoutes.register);
  }

  Future<void> completeOnboarding() async {
    await _storageService.setOnboardingCompleted(true);
    Get.offAllNamed(AppRoutes.welcome);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
