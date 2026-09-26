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

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0B0B0D),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  await Get.putAsync<StorageService>(() => StorageService().init());
  await Get.putAsync<ConnectivityService>(() => ConnectivityService().init());
  await Get.putAsync<ApiClient>(() => ApiClient().init());

  runApp(const HabitXApp());
}

class HabitXApp extends StatelessWidget {
  const HabitXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
      unknownRoute: AppPages.notFoundPage,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    );
  }
}
