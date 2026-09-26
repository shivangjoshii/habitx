import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/offline_banner.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryAccent(context),
                backgroundColor: AppColors.surface(context),
                onRefresh: controller.fetchDashboardData,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.greeting,
                                style: AppTypography.secondary.copyWith(color: AppColors.textSecondary(context)),
                              ),
                              const SizedBox(height: 2),
                              Obx(() => Text(
                                    '${controller.userName.value} 👋',
                                    style: AppTypography.largeHeading.copyWith(
                                      color: AppColors.textPrimary(context),
                                      fontSize: 22,
                                    ),
                                  )),
                              const SizedBox(height: 2),
                              Text(
                                controller.formattedDate,
                                style: AppTypography.caption.copyWith(color: AppColors.textTertiary(context)),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Iconsax.logout_copy, color: AppColors.textTertiary(context), size: 20),
                            onPressed: controller.logout,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      FadeInUp(
                        duration: const Duration(milliseconds: 450),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.surface(context),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.border(context)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Obx(() => Text(
                                            '${controller.focusedTodayMinutes.value}m',
                                            style: AppTypography.largeMetric.copyWith(
                                              color: AppColors.primaryAccent(context),
                                              fontSize: 38,
                                            ),
                                          )),
                                      Text(
                                        'focused today',
                                        style: AppTypography.secondary.copyWith(color: AppColors.textSecondary(context)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceSecondary(context),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: AppColors.border(context)),
                                    ),
                                    child: Obx(() => Row(
                                          children: [
                                            Icon(Iconsax.flash_copy, color: AppColors.warning(context), size: 16),
                                            const SizedBox(width: 6),
                                            Text(
                                              '${controller.streakDays.value}d streak',
                                              style: AppTypography.caption.copyWith(
                                                color: AppColors.textPrimary(context),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Obx(() => ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: controller.goalProgress,
                                      minHeight: 6,
                                      backgroundColor: AppColors.surfaceSecondary(context),
                                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryAccent(context)),
                                    ),
                                  )),
                              const SizedBox(height: 8),
                              Obx(() => Text(
                                    '${(controller.goalProgress * 100).toInt()}% of daily goal (${controller.dailyGoalMinutes.value}m)',
                                    style: AppTypography.caption.copyWith(color: AppColors.textTertiary(context)),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 100),
                        child: CustomButton(
                          text: 'Start Focus',
                          prefixIcon: Icon(
                            Iconsax.play_copy,
                            size: 18,
                            color: AppColors.isDark(context) ? AppColors.darkBackground : Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 150),
                        child: Text(
                          "TODAY'S HABITS",
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textTertiary(context),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 200),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.surface(context),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border(context)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceSecondary(context),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.border(context)),
                                ),
                                child: Icon(Iconsax.task_square_copy, size: 18, color: AppColors.primaryAccent(context)),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'No habits logged yet today',
                                      style: AppTypography.bodySemiBold.copyWith(color: AppColors.textPrimary(context)),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Habits keep your focus routine consistent',
                                      style: AppTypography.caption.copyWith(color: AppColors.textSecondary(context)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 250),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.surface(context),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.lavenderSoft(context)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Iconsax.magicpen_copy, size: 16, color: AppColors.primaryAccent(context)),
                                  const SizedBox(width: 8),
                                  Text(
                                    'AI FOCUS COMPANION',
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.primaryAccent(context),
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Your strongest focus window is in the evening between 7:00 PM and 9:00 PM.',
                                style: AppTypography.body.copyWith(color: AppColors.textPrimary(context)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Complete a 45-minute focus session today to maintain your streak.',
                                style: AppTypography.secondary.copyWith(color: AppColors.textSecondary(context)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          border: Border(top: BorderSide(color: AppColors.border(context), width: 1)),
        ),
        child: Obx(() => BottomNavigationBar(
              currentIndex: controller.selectedNavIndex.value,
              onTap: controller.onNavTapped,
              backgroundColor: AppColors.surface(context),
              selectedItemColor: AppColors.primaryAccent(context),
              unselectedItemColor: AppColors.textTertiary(context),
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.home_2_copy, size: 22),
                  activeIcon: Icon(Iconsax.home_2, size: 22),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.timer_1_copy, size: 22),
                  activeIcon: Icon(Iconsax.timer_1, size: 22),
                  label: 'Focus',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.chart_2_copy, size: 22),
                  activeIcon: Icon(Iconsax.chart_21, size: 22),
                  label: 'Insights',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.user_copy, size: 22),
                  activeIcon: Icon(Iconsax.user, size: 22),
                  label: 'You',
                ),
              ],
            )),
      ),
    );
  }
}
