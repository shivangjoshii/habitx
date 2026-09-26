import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/utils/custom_snackbar.dart';

class DashboardController extends GetxController {
  final ApiClient _apiClient = Get.find<ApiClient>();
  final StorageService _storageService = Get.find<StorageService>();

  final RxString userName = 'Focus Champion'.obs;
  final RxInt focusedTodayMinutes = 0.obs;
  final RxInt dailyGoalMinutes = 120.obs;
  final RxInt streakDays = 0.obs;
  final RxInt longestStreak = 0.obs;
  final RxInt totalXp = 0.obs;
  final RxInt userLevel = 1.obs;
  final RxInt timeReclaimedMinutes = 0.obs;
  final RxInt selectedNavIndex = 0.obs;
  final RxBool isLoading = false.obs;

  String get formattedDate {
    return DateFormat('EEEE, MMMM d').format(DateTime.now());
  }

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  double get goalProgress {
    if (dailyGoalMinutes.value == 0) return 0.0;
    return (focusedTodayMinutes.value / dailyGoalMinutes.value).clamp(0.0, 1.0);
  }

  @override
  void onInit() {
    super.onInit();
    _loadLocalUserData();
    fetchDashboardData();
  }

  void _loadLocalUserData() {
    final user = _storageService.getUser();
    if (user != null) {
      userName.value = user['name'] ?? 'Focus Champion';
      totalXp.value = user['totalXp'] ?? 0;
      userLevel.value = user['level'] ?? 1;
      streakDays.value = user['streakCurrent'] ?? 0;
      longestStreak.value = user['streakLongest'] ?? 0;
    }
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      final response = await _apiClient.get(ApiEndpoints.focusSummary);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        focusedTodayMinutes.value = data['today']['minutes'] ?? 0;
        dailyGoalMinutes.value = data['today']['targetMinutes'] ?? 120;
        timeReclaimedMinutes.value = data['week']['timeReclaimedMinutes'] ?? 0;
        streakDays.value = data['streak']['current'] ?? streakDays.value;
        longestStreak.value = data['streak']['longest'] ?? longestStreak.value;
      }
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  void onNavTapped(int index) {
    selectedNavIndex.value = index;
  }

  Future<void> logout() async {
    await _storageService.clearAuthData();
    CustomSnackbar.showInfo(title: 'Logged Out', message: 'Signed out from your account.');
    Get.offAllNamed(AppRoutes.welcome);
  }
}
