import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: controller.completeOnboarding,
                  child: Text(
                    'Skip',
                    style: AppTypography.button.copyWith(color: AppColors.darkTextTertiary),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeIn(
                          duration: const Duration(milliseconds: 600),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: AppColors.darkSurfaceSecondary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.lavenderLight.withValues(alpha: 0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                item.icon,
                                size: 52,
                                color: AppColors.lavenderLight,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        FadeInUp(
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.lavenderSoftDark,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.lavenderLight.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              item.highlight,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.lavenderLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 100),
                          child: Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: AppTypography.largeHeading.copyWith(
                              color: AppColors.darkTextPrimary,
                              height: 1.25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              item.subtitle,
                              textAlign: TextAlign.center,
                              style: AppTypography.body.copyWith(
                                color: AppColors.darkTextSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.items.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 6,
                        width: controller.currentPage.value == index ? 24 : 6,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index
                              ? AppColors.lavenderLight
                              : AppColors.darkBorder,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 32),
              Obx(() => CustomButton(
                    text: controller.currentPage.value == controller.items.length - 1
                        ? 'Get Started'
                        : 'Continue',
                    onPressed: controller.nextPage,
                  )),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
