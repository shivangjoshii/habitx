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

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

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
                  'Create Account',
                  style: AppTypography.largeHeading.copyWith(color: AppColors.textPrimary(context)),
                ),
              ),
              const SizedBox(height: 6),
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Begin your attention management journey.',
                  style: AppTypography.body.copyWith(color: AppColors.textSecondary(context)),
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 150),
                child: CustomTextField(
                  label: 'Full Name',
                  hintText: 'Pawan Kumar',
                  controller: controller.registerNameController,
                  prefixIcon: Icon(Iconsax.user_copy, size: 18, color: AppColors.textTertiary(context)),
                ),
              ),
              const SizedBox(height: 18),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: CustomTextField(
                  label: 'Email',
                  hintText: 'name@example.com',
                  controller: controller.registerEmailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Iconsax.sms_copy, size: 18, color: AppColors.textTertiary(context)),
                ),
              ),
              const SizedBox(height: 18),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 250),
                child: CustomTextField(
                  label: 'Password',
                  hintText: 'At least 6 characters',
                  controller: controller.registerPasswordController,
                  isPassword: true,
                  prefixIcon: Icon(Iconsax.lock_copy, size: 18, color: AppColors.textTertiary(context)),
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 300),
                child: Obx(() => CustomButton(
                      text: 'Create Account',
                      isLoading: controller.isLoading.value,
                      onPressed: controller.register,
                    )),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 350),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTypography.body.copyWith(color: AppColors.textSecondary(context)),
                    ),
                    GestureDetector(
                      onTap: () => Get.offNamed(AppRoutes.login),
                      child: Text(
                        'Sign in',
                        style: AppTypography.bodySemiBold.copyWith(color: AppColors.primaryAccent(context)),
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
