import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'custom_button.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.darkSurfaceSecondary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: const Center(
                  child: Icon(Iconsax.radar_copy, color: AppColors.lavenderLight, size: 32),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Page Not Found',
                style: AppTypography.sectionHeading.copyWith(color: AppColors.darkTextPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'The requested attention sanctuary route does not exist.',
                textAlign: TextAlign.center,
                style: AppTypography.secondary.copyWith(color: AppColors.darkTextSecondary),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Return Home',
                onPressed: () => Get.offAllNamed('/dashboard'),
                width: 180,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
