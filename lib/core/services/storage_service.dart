import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/app_constants.dart';

class StorageService extends GetxService {
  late final GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  String? getAccessToken() {
    return _box.read<String>(AppConstants.storageTokenKey);
  }

  Future<void> saveAccessToken(String token) async {
    await _box.write(AppConstants.storageTokenKey, token);
  }

  String? getRefreshToken() {
    return _box.read<String>(AppConstants.storageRefreshTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _box.write(AppConstants.storageRefreshTokenKey, token);
  }

  Map<String, dynamic>? getUser() {
    final data = _box.read(AppConstants.storageUserKey);
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    await _box.write(AppConstants.storageUserKey, user);
  }

  bool isOnboardingCompleted() {
    return _box.read<bool>(AppConstants.storageOnboardingCompletedKey) ?? false;
  }

  Future<void> setOnboardingCompleted(bool value) async {
    await _box.write(AppConstants.storageOnboardingCompletedKey, value);
  }

  String getThemeMode() {
    return _box.read<String>(AppConstants.storageThemeKey) ?? 'system';
  }

  Future<void> saveThemeMode(String theme) async {
    await _box.write(AppConstants.storageThemeKey, theme);
  }

  bool getRememberMe() {
    return _box.read<bool>('remember_me') ?? false;
  }

  Future<void> setRememberMe(bool value) async {
    await _box.write('remember_me', value);
  }

  String? getRememberEmail() {
    return _box.read<String>('remember_email');
  }

  Future<void> setRememberEmail(String email) async {
    await _box.write('remember_email', email);
  }

  Future<void> clearRememberEmail() async {
    await _box.remove('remember_email');
  }

  String? getRememberPassword() {
    return _box.read<String>('remember_password');
  }

  Future<void> setRememberPassword(String password) async {
    await _box.write('remember_password', password);
  }

  Future<void> clearRememberPassword() async {
    await _box.remove('remember_password');
  }

  String? getLastAuthMethod() {
    return _box.read<String>('last_auth_method');
  }

  Future<void> setLastAuthMethod(String method) async {
    await _box.write('last_auth_method', method);
  }

  bool get isLoggedIn {
    final token = getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clearAuthData() async {
    await _box.remove(AppConstants.storageTokenKey);
    await _box.remove(AppConstants.storageRefreshTokenKey);
    await _box.remove(AppConstants.storageUserKey);
  }
}
