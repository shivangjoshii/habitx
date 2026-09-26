import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/curved_auth_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurvedAuthHeader(
              title: 'Reset Password',
              subtitle: 'Request an OTP verification code to reset your account credentials.',
              showBackButton: true,
              height: 275,
              onBack: () => Get.back(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                        CustomButton(
                          text: 'Send OTP',
                          width: 100,
                          height: 48,
                          isLoading: controller.isLoading.value,
                          onPressed: controller.sendForgotPasswordOtp,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 50),
                    child: CustomTextField(
                      label: '6-Digit Reset Code',
                      hintText: '123456',
                      controller: controller.resetOtpController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icon(Iconsax.key_copy, size: 18, color: AppColors.textTertiary(context)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 100),
                    child: CustomTextField(
                      label: 'New Password',
                      hintText: 'At least 6 characters',
                      controller: controller.resetNewPasswordController,
                      isPassword: true,
                      prefixIcon: Icon(Iconsax.lock_copy, size: 18, color: AppColors.textTertiary(context)),
                    ),
                  ),
                  const SizedBox(height: 28),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 140),
                    child: Obx(() => CustomButton(
                          text: 'Update Password',
                          isLoading: controller.isLoading.value,
                          onPressed: controller.resetPassword,
                        )),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
