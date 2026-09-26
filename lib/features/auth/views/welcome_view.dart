import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/focus_orb_widget.dart';
import '../controllers/auth_controller.dart';

class WelcomeView extends GetView<AuthController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const Spacer(),
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: const FocusOrbWidget(size: 80),
              ),
              const SizedBox(height: 36),
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Text(
                  'Take back your attention.',
                  textAlign: TextAlign.center,
                  style: AppTypography.largeHeading.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 150),
                child: Column(
                  children: [
                    Text(
                      'Focus better.',
                      style: AppTypography.body.copyWith(color: AppColors.darkTextSecondary),
                    ),
                    Text(
                      'Scroll less.',
                      style: AppTypography.body.copyWith(color: AppColors.darkTextSecondary),
                    ),
                    Text(
                      'Build better habits.',
                      style: AppTypography.body.copyWith(color: AppColors.darkTextSecondary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 250),
                child: CustomButton(
                  text: 'Get Started',
                  onPressed: () => Get.toNamed(AppRoutes.register),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 350),
                child: CustomButton(
                  text: 'Sign In',
                  isSecondary: true,
                  onPressed: () => Get.toNamed(AppRoutes.login),
                ),
              ),
              const SizedBox(height: 16),
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 450),
                child: Obx(() => TextButton(
                      onPressed: controller.isGuestLoading.value ? null : controller.guestLogin,
                      child: controller.isGuestLoading.value
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkTextTertiary),
                              ),
                            )
                          : Text(
                              'Continue as Guest',
                              style: AppTypography.button.copyWith(
                                color: AppColors.darkTextTertiary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    )),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
