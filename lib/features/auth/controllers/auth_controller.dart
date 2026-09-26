import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/custom_snackbar.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient = Get.find<ApiClient>();
  final StorageService _storageService = Get.find<StorageService>();

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();

  final otpController = TextEditingController();
  final forgotEmailController = TextEditingController();
  final resetOtpController = TextEditingController();
  final resetNewPasswordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isGuestLoading = false.obs;
  final RxString pendingVerificationEmail = ''.obs;

  final RxInt resendTimer = 60.obs;
  Timer? _timer;

  void startResendCountdown() {
    resendTimer.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> login() async {
    final email = loginEmailController.text.trim();
    final password = loginPasswordController.text;

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      CustomSnackbar.showError(title: 'Invalid Email', message: 'Please enter a valid email address.');
      return;
    }

    if (password.isEmpty) {
      CustomSnackbar.showError(title: 'Missing Password', message: 'Please enter your password.');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final tokens = data['tokens'];
        final user = data['user'];

        await _storageService.saveAccessToken(tokens['accessToken']);
        await _storageService.saveRefreshToken(tokens['refreshToken']);
        await _storageService.saveUser(user);

        CustomSnackbar.showSuccess(title: 'Welcome Back', message: 'Signed in successfully.');
        Get.offAllNamed(AppRoutes.dashboard);
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Login failed. Please check your credentials.';
      CustomSnackbar.showError(title: 'Authentication Error', message: msg);
    } catch (_) {
      CustomSnackbar.showError(title: 'Connection Error', message: 'Unable to connect to server.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    final name = registerNameController.text.trim();
    final email = registerEmailController.text.trim();
    final password = registerPasswordController.text;

    if (name.isEmpty) {
      CustomSnackbar.showError(title: 'Missing Name', message: 'Please enter your name.');
      return;
    }

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      CustomSnackbar.showError(title: 'Invalid Email', message: 'Please enter a valid email address.');
      return;
    }

    if (password.length < 6) {
      CustomSnackbar.showError(title: 'Weak Password', message: 'Password must be at least 6 characters.');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiClient.post(
        ApiEndpoints.register,
        data: {'name': name, 'email': email, 'password': password},
      );

      if (response.statusCode == 201 && response.data['success'] == true) {
        final data = response.data['data'];
        final tokens = data['tokens'];
        final user = data['user'];

        await _storageService.saveAccessToken(tokens['accessToken']);
        await _storageService.saveRefreshToken(tokens['refreshToken']);
        await _storageService.saveUser(user);

        pendingVerificationEmail.value = email;
        startResendCountdown();

        CustomSnackbar.showSuccess(
          title: 'Account Created',
          message: 'A 6-digit OTP has been sent to your Gmail.',
        );

        Get.toNamed(AppRoutes.otpVerification);
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Registration failed.';
      CustomSnackbar.showError(title: 'Registration Error', message: msg);
    } catch (_) {
      CustomSnackbar.showError(title: 'Connection Error', message: 'Unable to connect to server.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyEmail() async {
    final otp = otpController.text.trim();
    final email = pendingVerificationEmail.value;

    if (otp.length != 6) {
      CustomSnackbar.showError(title: 'Invalid OTP', message: 'Please enter the 6-digit verification code.');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiClient.post(
        ApiEndpoints.verifyEmail,
        data: {'email': email, 'otp': otp},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final tokens = data['tokens'];
        final user = data['user'];

        await _storageService.saveAccessToken(tokens['accessToken']);
        await _storageService.saveRefreshToken(tokens['refreshToken']);
        await _storageService.saveUser(user);

        CustomSnackbar.showSuccess(
          title: 'Email Verified',
          message: 'Your account is ready. Welcome to HabitX!',
        );

        Get.offAllNamed(AppRoutes.dashboard);
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Invalid verification code.';
      CustomSnackbar.showError(title: 'Verification Failed', message: msg);
    } catch (_) {
      CustomSnackbar.showError(title: 'Connection Error', message: 'Unable to verify code.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendVerificationOtp() async {
    if (resendTimer.value > 0) return;

    final email = pendingVerificationEmail.value;
    try {
      final response = await _apiClient.post(
        ApiEndpoints.resendOtp,
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        startResendCountdown();
        CustomSnackbar.showSuccess(
          title: 'OTP Resent',
          message: 'A new verification code has been dispatched.',
        );
      }
    } catch (_) {
      CustomSnackbar.showError(title: 'Resend Failed', message: 'Could not send verification code.');
    }
  }

  Future<void> guestLogin() async {
    try {
      isGuestLoading.value = true;
      final response = await _apiClient.post(ApiEndpoints.guestLogin, data: {});

      if (response.statusCode == 201 && response.data['success'] == true) {
        final data = response.data['data'];
        final tokens = data['tokens'];
        final user = data['user'];

        await _storageService.saveAccessToken(tokens['accessToken']);
        await _storageService.saveRefreshToken(tokens['refreshToken']);
        await _storageService.saveUser(user);

        CustomSnackbar.showSuccess(
          title: 'Guest Session Active',
          message: 'Exploring in local guest mode.',
        );

        Get.offAllNamed(AppRoutes.dashboard);
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Could not start guest session.';
      CustomSnackbar.showError(title: 'Guest Mode Error', message: msg);
    } catch (_) {
      CustomSnackbar.showError(title: 'Connection Error', message: 'Unable to reach server.');
    } finally {
      isGuestLoading.value = false;
    }
  }

  Future<void> sendForgotPasswordOtp() async {
    final email = forgotEmailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      CustomSnackbar.showError(title: 'Invalid Email', message: 'Enter your registered email.');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiClient.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        pendingVerificationEmail.value = email;
        CustomSnackbar.showSuccess(
          title: 'Code Dispatched',
          message: 'If registered, a reset code was sent to your email.',
        );
      }
    } catch (_) {
      CustomSnackbar.showError(title: 'Error', message: 'Could not request password reset.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    final email = pendingVerificationEmail.value.isNotEmpty
        ? pendingVerificationEmail.value
        : forgotEmailController.text.trim();
    final otp = resetOtpController.text.trim();
    final newPassword = resetNewPasswordController.text;

    if (otp.length != 6) {
      CustomSnackbar.showError(title: 'Invalid OTP', message: 'Enter the 6-digit reset code.');
      return;
    }

    if (newPassword.length < 6) {
      CustomSnackbar.showError(title: 'Weak Password', message: 'Password must be at least 6 characters.');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiClient.post(
        ApiEndpoints.resetPassword,
        data: {'email': email, 'otp': otp, 'newPassword': newPassword},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        CustomSnackbar.showSuccess(
          title: 'Password Updated',
          message: 'You can now sign in with your new password.',
        );
        Get.offNamed(AppRoutes.login);
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Password reset failed.';
      CustomSnackbar.showError(title: 'Reset Error', message: msg);
    } catch (_) {
      CustomSnackbar.showError(title: 'Connection Error', message: 'Unable to connect to server.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
