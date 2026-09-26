import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/constants/app_constants.dart';
import 'core/network/api_client.dart';
import 'core/routing/app_pages.dart';
import 'core/services/connectivity_service.dart';
import 'core/services/storage_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final storageService = await Get.putAsync<StorageService>(() => StorageService().init());
  await Get.putAsync<ConnectivityService>(() => ConnectivityService().init());
  await Get.putAsync<ApiClient>(() => ApiClient().init());

  final savedTheme = storageService.getThemeMode();
  ThemeMode themeMode = ThemeMode.light;
  if (savedTheme == 'dark') {
    themeMode = ThemeMode.dark;
  } else if (savedTheme == 'system') {
    themeMode = ThemeMode.system;
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: themeMode == ThemeMode.dark ? const Color(0xFF0B0B0D) : const Color(0xFFF7F7F9),
      systemNavigationBarIconBrightness: themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
    ),
  );

  runApp(HabitXApp(initialThemeMode: themeMode));
}

class HabitXApp extends StatelessWidget {
  final ThemeMode initialThemeMode;

  const HabitXApp({super.key, this.initialThemeMode = ThemeMode.light});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: initialThemeMode,
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
      unknownRoute: AppPages.notFoundPage,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    );
  }
}
