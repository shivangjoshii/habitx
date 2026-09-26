import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'focus_orb_widget.dart';

class DeviceMockupFrame extends StatelessWidget {
  final int pageIndex;

  const DeviceMockupFrame({
    super.key,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isIos = defaultTargetPlatform == TargetPlatform.iOS;
    final isDark = AppColors.isDark(context);
    final borderColor = isDark ? const Color(0xFF383842) : const Color(0xFFD4D4DC);
    final frameColor = isDark ? const Color(0xFF18181C) : const Color(0xFFE8E8EE);
    final screenBg = isDark ? const Color(0xFF0E0E11) : const Color(0xFFFFFFFF);

    return SizedBox(
      width: 250,
      height: 380,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: -3,
            top: 70,
            child: Container(
              width: 3,
              height: 28,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                ),
              ),
            ),
          ),
          Positioned(
            left: -3,
            top: 110,
            child: Container(
              width: 3,
              height: 28,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                ),
              ),
            ),
          ),
          Positioned(
            right: -3,
            top: 85,
            child: Container(
              width: 3,
              height: 42,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
              ),
            ),
          ),
          Container(
            width: 244,
            height: 380,
            decoration: BoxDecoration(
              color: frameColor,
              borderRadius: BorderRadius.circular(isIos ? 36 : 24),
              border: Border.all(color: borderColor, width: 3),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isIos ? 32 : 20),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: screenBg,
                    child: Column(
                      children: [
                        SizedBox(height: isIos ? 32 : 24),
                        Expanded(
                          child: _buildMockupContent(context, pageIndex),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: isIos ? 8 : 6,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: isIos ? _buildIosDynamicIsland(isDark) : _buildAndroidPunchHole(isDark),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 90,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.background(context).withValues(alpha: 0.95),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIosDynamicIsland(bool isDark) {
    return Container(
      width: 68,
      height: 16,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : const Color(0xFF1A1A1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 6),
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Color(0xFF0F2236),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAndroidPunchHole(bool isDark) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : const Color(0xFF1E1E24),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF3A3A44), width: 1),
      ),
    );
  }

  Widget _buildMockupContent(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _buildFocusScreen(context);
      case 1:
        return _buildBlockingScreen(context);
      case 2:
        return _buildHabitsScreen(context);
      case 3:
      default:
        return _buildAIScreen(context);
    }
  }

  Widget _buildFocusScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          const SizedBox(height: 6),
          Text(
            'Mathematics',
            style: AppTypography.bodySemiBold.copyWith(
              color: AppColors.textPrimary(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          const FocusOrbWidget(size: 68),
          const SizedBox(height: 12),
          Text(
            '24:32',
            style: AppTypography.largeHeading.copyWith(
              color: AppColors.primaryAccent(context),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary(context),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.shield_tick_copy, size: 11, color: AppColors.primaryAccent(context)),
                const SizedBox(width: 4),
                Text(
                  '3 apps protected',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary(context),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlockingScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.lavenderSoft(context),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(Iconsax.shield_cross_copy, color: AppColors.primaryAccent(context), size: 22),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Stay with your focus',
            style: AppTypography.bodySemiBold.copyWith(
              color: AppColors.textPrimary(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Instagram Reels Blocked',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary(context),
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryAccent(context),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Return to Focus',
              style: AppTypography.button.copyWith(
                color: AppColors.isDark(context) ? AppColors.darkBackground : Colors.white,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitsScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Habits",
                style: AppTypography.bodySemiBold.copyWith(
                  color: AppColors.textPrimary(context),
                  fontSize: 12,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary(context),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.flash_copy, color: AppColors.warningLight, size: 10),
                    const SizedBox(width: 2),
                    Text(
                      '12d',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textPrimary(context),
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildHabitItem(context, 'Study 2 Hours', true),
          const SizedBox(height: 6),
          _buildHabitItem(context, 'Read 20 Pages', true),
          const SizedBox(height: 6),
          _buildHabitItem(context, 'Deep Meditation', false),
        ],
      ),
    );
  }

  Widget _buildHabitItem(BuildContext context, String title, bool completed) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border(context), width: 0.8),
      ),
      child: Row(
        children: [
          Icon(
            completed ? Iconsax.tick_circle_copy : Iconsax.record_circle_copy,
            color: completed ? AppColors.success(context) : AppColors.textTertiary(context),
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: AppTypography.caption.copyWith(
              color: AppColors.textPrimary(context),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Iconsax.magicpen_copy, size: 12, color: AppColors.primaryAccent(context)),
              const SizedBox(width: 4),
              Text(
                'Focus Companion',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primaryAccent(context),
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary(context),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border(context), width: 0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Best Window: 7:00–9:00 PM',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textPrimary(context),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '+23% focus time this week',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary(context),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary(context),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border(context), width: 0.8),
            ),
            child: Row(
              children: [
                Icon(Iconsax.people_copy, size: 12, color: AppColors.primaryAccent(context)),
                const SizedBox(width: 6),
                Text(
                  '42 studying together in GATE Sprint',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textPrimary(context),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
