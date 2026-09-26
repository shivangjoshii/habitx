import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/curved_auth_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurvedAuthHeader(
              title: 'Create Account',
              subtitle: 'Begin your attention & habit mastery journey.',
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
                      label: 'Full Name',
                      hintText: 'Pawan Kumar',
                      controller: controller.registerNameController,
                      prefixIcon: Icon(Iconsax.user_copy, size: 18, color: AppColors.textTertiary(context)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 50),
                    child: CustomTextField(
                      label: 'Email Address',
                      hintText: 'name@example.com',
                      controller: controller.registerEmailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(Iconsax.sms_copy, size: 18, color: AppColors.textTertiary(context)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 100),
                    child: CustomTextField(
                      label: 'Password',
                      hintText: 'At least 6 characters',
                      controller: controller.registerPasswordController,
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
                          text: 'Create Account',
                          isLoading: controller.isLoading.value,
                          onPressed: controller.register,
                        )),
                  ),
                  const SizedBox(height: 28),
                  FadeInUp(
                    from: 10,
                    duration: const Duration(milliseconds: 320),
                    delay: const Duration(milliseconds: 180),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.offNamed(AppRoutes.login),
                          child: Text(
                            'Sign in',
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
