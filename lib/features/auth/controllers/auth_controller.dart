import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/custom_snackbar.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient = Get.find<ApiClient>();
  final StorageService _storageService = Get.find<StorageService>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();

  final forgotSheetEmailController = TextEditingController();

  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes =
      List.generate(6, (_) => FocusNode());

  final resetNewPasswordController = TextEditingController();
  final resetConfirmPasswordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;
  final RxBool isSuccess = false.obs;
  final RxBool rememberMe = false.obs;
  final RxString lastAuthMethod = ''.obs;

  final RxString otpFlowType = 'registration'.obs;
  final RxString otpTarget = ''.obs;
  final RxString verifiedResetOtp = ''.obs;

  final RxInt timerSeconds = 60.obs;
  Timer? _timer;

  String get fullOtp => otpControllers.map((c) => c.text.trim()).join();

  bool _isValidEmail(String email) {
    final clean = email.trim().toLowerCase();
    if (clean.isEmpty) return false;
    return RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$').hasMatch(clean);
  }

  @override
  void onInit() {
    super.onInit();
    _loadSavedPreferences();
  }

  void _loadSavedPreferences() {
    rememberMe.value = _storageService.getRememberMe();
    if (rememberMe.value) {
      final savedEmail = _storageService.getRememberEmail();
      final savedPassword = _storageService.getRememberPassword();
      if (savedEmail != null && savedEmail.isNotEmpty) {
        loginEmailController.text = savedEmail;
      }
      if (savedPassword != null && savedPassword.isNotEmpty) {
        loginPasswordController.text = savedPassword;
      }
    }
    lastAuthMethod.value = _storageService.getLastAuthMethod() ?? '';
  }

  void toggleRememberMe(bool? val) {
    rememberMe.value = val ?? false;
  }

  void clearOtp() {
    for (var c in otpControllers) {
      c.clear();
    }
    if (otpFocusNodes.isNotEmpty) {
      otpFocusNodes[0].requestFocus();
    }
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        otpFocusNodes[index + 1].requestFocus();
      } else {
        otpFocusNodes[index].unfocus();
        if (fullOtp.length == 6) {
          verifyOtp();
        }
      }
    }
  }

  KeyEventResult handleOtpKey(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (otpControllers[index].text.isEmpty && index > 0) {
        otpFocusNodes[index - 1].requestFocus();
        otpControllers[index - 1].clear();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  void startResendCountdown() {
    timerSeconds.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> login() async {
    final email = loginEmailController.text.trim();
    final password = loginPasswordController.text;

    if (email.isEmpty || !_isValidEmail(email)) {
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
        data: {'email': email.toLowerCase(), 'password': password},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final tokens = data['tokens'];
        final user = data['user'];

        await _storageService.saveAccessToken(tokens['accessToken']);
        await _storageService.saveRefreshToken(tokens['refreshToken']);
        await _storageService.saveUser(user);

        if (rememberMe.value) {
          await _storageService.setRememberMe(true);
          await _storageService.setRememberEmail(email);
          await _storageService.setRememberPassword(password);
        } else {
          await _storageService.setRememberMe(false);
          await _storageService.clearRememberEmail();
          await _storageService.clearRememberPassword();
        }

        await _storageService.setLastAuthMethod('manual');
        lastAuthMethod.value = 'manual';

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

  Future<void> loginWithGoogle() async {
    try {
      isGoogleLoading.value = true;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final token = googleAuth.idToken ?? googleAuth.accessToken ?? 'google_auth_token';

      final response = await _apiClient.post(
        '/auth/oauth',
        data: {
          'provider': 'google',
          'email': googleUser.email,
          'name': googleUser.displayName ?? 'Focus Champion',
          'providerId': googleUser.id,
          'token': token,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final tokens = data['tokens'];
        final user = data['user'];

        await _storageService.saveAccessToken(tokens['accessToken']);
        await _storageService.saveRefreshToken(tokens['refreshToken']);
        await _storageService.saveUser(user);

        await _storageService.setLastAuthMethod('google');
        lastAuthMethod.value = 'google';

        CustomSnackbar.showSuccess(title: 'Google Sign In', message: 'Signed in with Google successfully.');
        Get.offAllNamed(AppRoutes.dashboard);
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Google sign in failed.';
      CustomSnackbar.showError(title: 'Google Auth Error', message: msg);
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      CustomSnackbar.showError(title: 'Google Sign In', message: 'Unable to complete Google sign in: $e');
    } finally {
      isGoogleLoading.value = false;
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

    if (email.isEmpty || !_isValidEmail(email)) {
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
        data: {'name': name, 'email': email.toLowerCase(), 'password': password},
      );

      if (response.statusCode == 201 && response.data['success'] == true) {
        final data = response.data['data'];
        final tokens = data['tokens'];
        final user = data['user'];

        await _storageService.saveAccessToken(tokens['accessToken']);
        await _storageService.saveRefreshToken(tokens['refreshToken']);
        await _storageService.saveUser(user);

        otpFlowType.value = 'registration';
        otpTarget.value = email.toLowerCase();
        clearOtp();
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

  Future<void> sendForgotPasswordOtpFromSheet() async {
    final email = forgotSheetEmailController.text.trim();
    if (email.isEmpty || !_isValidEmail(email)) {
      CustomSnackbar.showError(title: 'Invalid Email', message: 'Enter your registered email address.');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _apiClient.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email.toLowerCase()},
      );

      if (response.statusCode == 200) {
        Get.back();
        otpFlowType.value = 'forgotPassword';
        otpTarget.value = email.toLowerCase();
        clearOtp();
        startResendCountdown();

        CustomSnackbar.showSuccess(
          title: 'Code Dispatched',
          message: '6-digit reset code sent to $email.',
        );

        Get.toNamed(AppRoutes.otpVerification);
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Could not dispatch reset code.';
      CustomSnackbar.showError(title: 'Error', message: msg);
    } catch (_) {
      CustomSnackbar.showError(title: 'Connection Error', message: 'Unable to connect to server.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    final otp = fullOtp;
    final email = otpTarget.value;

    if (otp.length != 6) {
      CustomSnackbar.showError(title: 'Incomplete Code', message: 'Please enter all 6 digits.');
      return;
    }

    try {
      isLoading.value = true;

      if (otpFlowType.value == 'registration') {
        final response = await _apiClient.post(
          ApiEndpoints.verifyEmail,
          data: {'email': email, 'otp': otp},
        );

        if (response.statusCode == 200 && response.data['success'] == true) {
          isSuccess.value = true;
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

          await Future.delayed(const Duration(milliseconds: 300));
          Get.offAllNamed(AppRoutes.dashboard);
        }
      } else {
        verifiedResetOtp.value = otp;
        isSuccess.value = true;

        CustomSnackbar.showSuccess(
          title: 'Code Verified',
          message: 'Please set your new password.',
        );

        await Future.delayed(const Duration(milliseconds: 300));
        Get.offNamed(AppRoutes.forgotPassword);
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Invalid verification code.';
      CustomSnackbar.showError(title: 'Verification Failed', message: msg);
    } catch (_) {
      CustomSnackbar.showError(title: 'Connection Error', message: 'Unable to verify code.');
    } finally {
      isLoading.value = false;
      isSuccess.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (timerSeconds.value > 0) return;

    final email = otpTarget.value;
    final endpoint = otpFlowType.value == 'registration'
        ? ApiEndpoints.resendOtp
        : ApiEndpoints.forgotPassword;

    try {
      final response = await _apiClient.post(
        endpoint,
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        startResendCountdown();
        CustomSnackbar.showSuccess(
          title: 'Code Resent',
          message: 'A new 6-digit code has been dispatched.',
        );
      }
    } catch (_) {
      CustomSnackbar.showError(title: 'Resend Failed', message: 'Could not send verification code.');
    }
  }

  Future<void> resetPassword() async {
    final email = otpTarget.value;
    final otp = verifiedResetOtp.value;
    final newPassword = resetNewPasswordController.text;
    final confirmPassword = resetConfirmPasswordController.text;

    if (newPassword.length < 6) {
      CustomSnackbar.showError(title: 'Weak Password', message: 'Password must be at least 6 characters.');
      return;
    }

    if (newPassword != confirmPassword) {
      CustomSnackbar.showError(title: 'Mismatch', message: 'Passwords do not match.');
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
        resetNewPasswordController.clear();
        resetConfirmPasswordController.clear();
        Get.offAllNamed(AppRoutes.login);
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
