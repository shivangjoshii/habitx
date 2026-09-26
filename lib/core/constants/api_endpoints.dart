import 'package:flutter/foundation.dart';

class ApiEndpoints {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:5000/api/v1';
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.190.44.185:5000/api/v1';
    } else {
      return 'http://localhost:5000/api/v1';
    }
  }

  static const String health = '/health';

  static const String register = '/auth/register';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendOtp = '/auth/resend-otp';
  static const String login = '/auth/login';
  static const String guestLogin = '/auth/guest';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String refreshToken = '/auth/refresh-token';

  static const String profile = '/users/profile';
  static const String preferences = '/users/preferences';
  static const String onboarding = '/users/onboarding';
  static const String changePassword = '/users/change-password';
  static const String avatar = '/users/avatar';
  static const String exportData = '/users/export';
  static const String deleteAccount = '/users/account';

  static const String startFocus = '/focus/start';
  static const String activeFocus = '/focus/active';
  static const String focusSummary = '/focus/summary';
  static const String focusHistory = '/focus/history';

  static const String appRules = '/blocking/apps';
  static const String activeRules = '/blocking/active-rules';

  static const String habits = '/habits';
  static const String goals = '/goals';
  static const String schedules = '/schedules';
  static const String publicRooms = '/rooms/public';
  static const String leaderboard = '/leaderboard';
  static const String gamificationOverview = '/gamification/overview';
  static const String aiCompanion = '/ai/companion';
  static const String screenTimeDaily = '/screen-time/daily';
  static const String notifications = '/notifications';
  static const String musicTracks = '/music/tracks';
  static const String batchSync = '/sync/batch';
}
