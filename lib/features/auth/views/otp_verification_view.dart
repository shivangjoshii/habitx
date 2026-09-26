import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/curved_auth_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/auth_controller.dart';

class OtpVerificationView extends GetView<AuthController> {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 54,
      textStyle: GoogleFonts.plusJakartaSans(
        color: AppColors.primaryAccent(context),
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryAccent(context), width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurvedAuthHeader(
              title: 'Verify Email',
              subtitle: 'Enter the 6-digit verification code dispatched to your inbox.',
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
                    child: Obx(() => Text(
                          'Code sent to: ${controller.pendingVerificationEmail.value}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: AppColors.textSecondary(context),
                          ),
                        )),
                  ),
                  const SizedBox(height: 28),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 60),
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
                  const SizedBox(height: 32),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 100),
                    child: Obx(() => CustomButton(
                          text: 'Verify & Enter HabitX',
                          isLoading: controller.isLoading.value,
                          onPressed: controller.verifyEmail,
                        )),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 140),
                    child: Center(
                      child: Obx(() {
                        if (controller.resendTimer.value > 0) {
                          return Text(
                            'Resend code in ${controller.resendTimer.value}s',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: AppColors.textTertiary(context),
                            ),
                          );
                        }
                        return TextButton(
                          onPressed: controller.resendVerificationOtp,
                          child: Text(
                            'Resend code',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryAccent(context),
                            ),
                          ),
                        );
                      }),
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
