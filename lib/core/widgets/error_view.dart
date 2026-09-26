import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'custom_button.dart';

class ErrorView extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;

  const ErrorView({
    super.key,
    this.title = 'Something went wrong',
    this.message = 'Unable to complete the operation. Your local data remains intact.',
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
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
                  color: AppColors.error(context).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.error(context).withValues(alpha: 0.3)),
                ),
                child: Center(
                  child: Icon(Iconsax.warning_2_copy, color: AppColors.error(context), size: 32),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.sectionHeading.copyWith(color: AppColors.textPrimary(context)),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTypography.secondary.copyWith(color: AppColors.textSecondary(context)),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Try Again',
                onPressed: onRetry,
                width: 180,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
