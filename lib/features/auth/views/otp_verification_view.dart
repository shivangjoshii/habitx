import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinput/pinput.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/auth_controller.dart';

class OtpVerificationView extends GetView<AuthController> {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 56,
      textStyle: AppTypography.largeHeading.copyWith(
        color: AppColors.lavenderLight,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lavenderLight, width: 1.5),
      ),
    );

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
                  'Verify Email',
                  style: AppTypography.largeHeading.copyWith(color: AppColors.darkTextPrimary),
                ),
              ),
              const SizedBox(height: 6),
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 100),
                child: Obx(() => Text(
                      'Enter the 6-digit code dispatched to ${controller.pendingVerificationEmail.value}.',
                      style: AppTypography.body.copyWith(color: AppColors.darkTextSecondary),
                    )),
              ),
              const SizedBox(height: 36),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 150),
                child: Center(
                  child: Pinput(
                    length: 6,
                    controller: controller.otpController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    autofocus: true,
                    onCompleted: (_) => controller.verifyEmail(),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: Obx(() => CustomButton(
                      text: 'Verify & Enter HabitX',
                      isLoading: controller.isLoading.value,
                      onPressed: controller.verifyEmail,
                    )),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 250),
                child: Center(
                  child: Obx(() {
                    if (controller.resendTimer.value > 0) {
                      return Text(
                        'Resend code in ${controller.resendTimer.value}s',
                        style: AppTypography.secondary.copyWith(color: AppColors.darkTextTertiary),
                      );
                    }
                    return TextButton(
                      onPressed: controller.resendVerificationOtp,
                      child: Text(
                        'Resend code',
                        style: AppTypography.bodySemiBold.copyWith(color: AppColors.lavenderLight),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
