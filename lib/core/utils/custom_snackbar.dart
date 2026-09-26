import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class CustomSnackbar {
  static void showSuccess({required String title, required String message}) {
    final isDark = Get.isDarkMode;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      colorText: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
      icon: const Icon(Iconsax.tick_circle_copy, color: AppColors.successLight, size: 22),
      borderRadius: 14,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: const Duration(seconds: 3),
      borderColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
      borderWidth: 1,
      titleText: Text(
        title,
        style: AppTypography.bodySemiBold.copyWith(
          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        ),
      ),
      messageText: Text(
        message,
        style: AppTypography.secondary.copyWith(
          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        ),
      ),
    );
  }

  static void showError({required String title, required String message}) {
    final isDark = Get.isDarkMode;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      colorText: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
      icon: const Icon(Iconsax.warning_2_copy, color: AppColors.errorLight, size: 22),
      borderRadius: 14,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: const Duration(seconds: 4),
      borderColor: AppColors.errorLight.withValues(alpha: 0.3),
      borderWidth: 1,
      titleText: Text(
        title,
        style: AppTypography.bodySemiBold.copyWith(
          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        ),
      ),
      messageText: Text(
        message,
        style: AppTypography.secondary.copyWith(
          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        ),
      ),
    );
  }

  static void showInfo({required String title, required String message}) {
    final isDark = Get.isDarkMode;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      colorText: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
      icon: const Icon(Iconsax.info_circle_copy, color: AppColors.lavender, size: 22),
      borderRadius: 14,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: const Duration(seconds: 3),
      borderColor: AppColors.lavender.withValues(alpha: 0.3),
      borderWidth: 1,
      titleText: Text(
        title,
        style: AppTypography.bodySemiBold.copyWith(
          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        ),
      ),
      messageText: Text(
        message,
        style: AppTypography.secondary.copyWith(
          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}
