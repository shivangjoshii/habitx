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
      title: 'A calm operating system for your attention.',
      subtitle: 'Structure your work and study sessions with distraction-free timers and intelligent session pacing.',
      highlight: 'Deep Focus',
      icon: Iconsax.timer_1_copy,
    ),
    OnboardingItem(
      title: 'Eliminate mindless scrolling & app loops.',
      subtitle: 'Shield your mind from Reels, Shorts, and distracting feeds with native intervention screens.',
      highlight: 'Block Distractions',
      icon: Iconsax.shield_cross_copy,
    ),
    OnboardingItem(
      title: 'Build unbreakable streaks & daily routines.',
      subtitle: 'Connect your study targets with daily habits, progress metrics, and intentional time tracking.',
      highlight: 'Intentional Living',
      icon: Iconsax.chart_square_copy,
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
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
