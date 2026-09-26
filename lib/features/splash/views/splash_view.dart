import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/focus_orb_widget.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 900),
              child: const FocusOrbWidget(
                size: 88,
                isPulsing: true,
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              duration: const Duration(milliseconds: 900),
              delay: const Duration(milliseconds: 200),
              child: Text(
                AppConstants.appName,
                style: AppTypography.largeHeading.copyWith(
                  color: AppColors.darkTextPrimary,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeInUp(
              duration: const Duration(milliseconds: 900),
              delay: const Duration(milliseconds: 350),
              child: Text(
                AppConstants.appTagline,
                style: AppTypography.secondary.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
