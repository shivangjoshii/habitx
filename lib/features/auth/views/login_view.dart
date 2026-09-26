import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_curved_bottom_sheet.dart';
import '../../../core/widgets/curved_auth_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  void _showForgotPasswordSheet(BuildContext context) {
    AppCurvedBottomSheet.show(
      context,
      title: 'Forgot Password',
      subtitle: 'Enter your registered email to receive a 6-digit OTP code.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Registered Email',
            hintText: 'name@example.com',
            controller: controller.forgotSheetEmailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(Iconsax.sms_copy, size: 18, color: AppColors.textTertiary(context)),
          ),
          const SizedBox(height: 24),
          Obx(
            () => CustomButton(
              text: 'Send Verification Code',
              isLoading: controller.isLoading.value,
              onPressed: controller.sendForgotPasswordOtpFromSheet,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurvedAuthHeader(
              title: 'Welcome Back',
              subtitle: 'Sign in to access your focus sanctuary.',
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
                    child: CustomTextField(
                      label: 'Email Address',
                      hintText: 'name@example.com',
                      controller: controller.loginEmailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(Iconsax.sms_copy, size: 18, color: AppColors.textTertiary(context)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 50),
                    child: CustomTextField(
                      label: 'Password',
                      hintText: '••••••••',
                      controller: controller.loginPasswordController,
                      isPassword: true,
                      prefixIcon: Icon(Iconsax.lock_copy, size: 18, color: AppColors.textTertiary(context)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 80),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _showForgotPasswordSheet(context),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          'Forgot password?',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: AppColors.primaryAccent(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 110),
                    child: Obx(() => CustomButton(
                          text: 'Sign In',
                          isLoading: controller.isLoading.value,
                          onPressed: controller.login,
                        )),
                  ),
                  const SizedBox(height: 28),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 140),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.offNamed(AppRoutes.register),
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryAccent(context),
                            ),
                          ),
                        ),
                      ],
                    ),
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
