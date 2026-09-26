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
      backgroundColor: AppColors.background(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 800),
              child: const FocusOrbWidget(
                size: 84,
                isPulsing: true,
              ),
            ),
            const SizedBox(height: 28),
            FadeInUp(
              duration: const Duration(milliseconds: 700),
              delay: const Duration(milliseconds: 150),
              child: Text(
                AppConstants.appName,
                style: AppTypography.largeHeading.copyWith(
                  color: AppColors.textPrimary(context),
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 6),
            FadeInUp(
              duration: const Duration(milliseconds: 700),
              delay: const Duration(milliseconds: 300),
              child: Text(
                AppConstants.appTagline,
                style: AppTypography.secondary.copyWith(
                  color: AppColors.textSecondary(context),
                  fontSize: 13,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
