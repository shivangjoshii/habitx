import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.background(context),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_copy, color: AppColors.textPrimary(context), size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'Reset Password',
                  style: AppTypography.largeHeading.copyWith(color: AppColors.textPrimary(context)),
                ),
              ),
              const SizedBox(height: 6),
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Request a 6-digit OTP code to update your password.',
                  style: AppTypography.body.copyWith(color: AppColors.textSecondary(context)),
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 150),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Registered Email',
                        hintText: 'name@example.com',
                        controller: controller.forgotEmailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Iconsax.sms_copy, size: 18, color: AppColors.textTertiary(context)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: CustomButton(
                        text: 'Send OTP',
                        width: 100,
                        height: 48,
                        isLoading: controller.isLoading.value,
                        onPressed: controller.sendForgotPasswordOtp,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: CustomTextField(
                  label: '6-Digit Reset Code',
                  hintText: '123456',
                  controller: controller.resetOtpController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(Iconsax.key_copy, size: 18, color: AppColors.textTertiary(context)),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 250),
                child: CustomTextField(
                  label: 'New Password',
                  hintText: 'At least 6 characters',
                  controller: controller.resetNewPasswordController,
                  isPassword: true,
                  prefixIcon: Icon(Iconsax.lock_copy, size: 18, color: AppColors.textTertiary(context)),
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 300),
                child: Obx(() => CustomButton(
                      text: 'Update Password',
                      isLoading: controller.isLoading.value,
                      onPressed: controller.resetPassword,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
