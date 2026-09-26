import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class CustomSnackbar {
  static void showSuccess({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.darkSurface,
      colorText: AppColors.darkTextPrimary,
      icon: const Icon(Iconsax.tick_circle_copy, color: AppColors.successDark, size: 22),
      borderRadius: 14,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: const Duration(seconds: 3),
      borderColor: AppColors.darkBorder,
      borderWidth: 1,
      titleText: Text(
        title,
        style: AppTypography.bodySemiBold.copyWith(color: AppColors.darkTextPrimary),
      ),
      messageText: Text(
        message,
        style: AppTypography.secondary.copyWith(color: AppColors.darkTextSecondary),
      ),
    );
  }

  static void showError({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.darkSurface,
      colorText: AppColors.darkTextPrimary,
      icon: const Icon(Iconsax.warning_2_copy, color: AppColors.errorDark, size: 22),
      borderRadius: 14,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: const Duration(seconds: 4),
      borderColor: AppColors.errorDark.withValues(alpha: 0.3),
      borderWidth: 1,
      titleText: Text(
        title,
        style: AppTypography.bodySemiBold.copyWith(color: AppColors.darkTextPrimary),
      ),
      messageText: Text(
        message,
        style: AppTypography.secondary.copyWith(color: AppColors.darkTextSecondary),
      ),
    );
  }

  static void showInfo({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.darkSurface,
      colorText: AppColors.darkTextPrimary,
      icon: const Icon(Iconsax.info_circle_copy, color: AppColors.lavenderLight, size: 22),
      borderRadius: 14,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: const Duration(seconds: 3),
      borderColor: AppColors.lavenderLight.withValues(alpha: 0.3),
      borderWidth: 1,
      titleText: Text(
        title,
        style: AppTypography.bodySemiBold.copyWith(color: AppColors.darkTextPrimary),
      ),
      messageText: Text(
        message,
        style: AppTypography.secondary.copyWith(color: AppColors.darkTextSecondary),
      ),
    );
  }
}
