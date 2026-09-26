import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy, color: AppColors.darkTextPrimary, size: 20),
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
                  'Welcome Back',
                  style: AppTypography.largeHeading.copyWith(color: AppColors.darkTextPrimary),
                ),
              ),
              const SizedBox(height: 6),
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Enter your credentials to access your focus sanctuary.',
                  style: AppTypography.body.copyWith(color: AppColors.darkTextSecondary),
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 150),
                child: CustomTextField(
                  label: 'Email',
                  hintText: 'name@example.com',
                  controller: controller.loginEmailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Iconsax.sms_copy, size: 18, color: AppColors.darkTextTertiary),
                ),
              ),
              const SizedBox(height: 18),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 250),
                child: CustomTextField(
                  label: 'Password',
                  hintText: '••••••••',
                  controller: controller.loginPasswordController,
                  isPassword: true,
                  prefixIcon: const Icon(Iconsax.lock_copy, size: 18, color: AppColors.darkTextTertiary),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 300),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      'Forgot password?',
                      style: AppTypography.secondary.copyWith(
                        color: AppColors.lavenderLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 350),
                child: Obx(() => CustomButton(
                      text: 'Sign In',
                      isLoading: controller.isLoading.value,
                      onPressed: controller.login,
                    )),
              ),
              const SizedBox(height: 16),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 400),
                child: CustomButton(
                  text: 'Continue as Guest',
                  isSecondary: true,
                  onPressed: controller.guestLogin,
                ),
              ),
              const SizedBox(height: 36),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 450),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTypography.body.copyWith(color: AppColors.darkTextSecondary),
                    ),
                    GestureDetector(
                      onTap: () => Get.offNamed(AppRoutes.register),
                      child: Text(
                        'Sign up',
                        style: AppTypography.bodySemiBold.copyWith(color: AppColors.lavenderLight),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
