import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/curved_auth_header.dart';
import '../../../core/widgets/habitx_loader.dart';
import '../controllers/auth_controller.dart';

class OtpVerificationView extends GetView<AuthController> {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => CurvedAuthHeader(
                title: 'Verify Code',
                subtitle:
                    'Verification code sent to ${controller.otpTarget.value.isNotEmpty ? controller.otpTarget.value : "your email"}.',
                showBackButton: true,
                height: 280,
                onBack: () => Get.back(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    child: Text(
                      'Enter 6-Digit OTP',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: 48,
                          height: 56,
                          child: Focus(
                            onKeyEvent: (node, event) =>
                                controller.handleOtpKey(index, event),
                            child: TextField(
                              controller: controller.otpControllers[index],
                              focusNode: controller.otpFocusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary(context),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(1),
                              ],
                              onChanged: (val) =>
                                  controller.onOtpChanged(val, index),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.surfaceSecondary(context),
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: AppColors.border(context),
                                    width: 1.2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: AppColors.primaryAccent(context),
                                    width: 1.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 100),
                    child: Obx(() {
                      final isBusy = controller.isLoading.value;
                      final isSuccess = controller.isSuccess.value;

                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (isBusy || isSuccess)
                              ? null
                              : controller.verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSuccess
                                ? AppColors.success(context)
                                : AppColors.primaryAccent(context),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: isBusy
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: HabitXLoader(size: 24),
                                )
                              : isSuccess
                                  ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Verify & Continue',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 140),
                    child: Center(
                      child: Obx(
                        () => controller.timerSeconds.value > 0
                            ? Text(
                                'Resend code in 00:${controller.timerSeconds.value.toString().padLeft(2, "0")}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: AppColors.textTertiary(context),
                                ),
                              )
                            : TextButton(
                                onPressed: controller.resendOtp,
                                child: Text(
                                  'Resend Code',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: AppColors.primaryAccent(context),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
