import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/focus_orb_widget.dart';
import '../models/onboarding_item.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingItem item;
  final int pageIndex;

  const OnboardingPageWidget({
    super.key,
    required this.item,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final chassisColor = isDark ? const Color(0xFF1E1E24) : const Color(0xFF1A1A1A);
    final phoneScreenBg = isDark ? const Color(0xFF121216) : Colors.white;

    return Column(
      children: [
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FadeInUp(
            duration: const Duration(milliseconds: 450),
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary(context),
                letterSpacing: -0.3,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FadeInUp(
            duration: const Duration(milliseconds: 450),
            delay: const Duration(milliseconds: 80),
            child: Text(
              item.subtitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary(context),
                letterSpacing: -0.1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: FadeInUp(
            duration: const Duration(milliseconds: 550),
            delay: const Duration(milliseconds: 140),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 27,
                  top: 125,
                  child: Container(
                    width: 3,
                    height: 44,
                    decoration: BoxDecoration(
                      color: chassisColor,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 27,
                  top: 185,
                  child: Container(
                    width: 3,
                    height: 30,
                    decoration: BoxDecoration(
                      color: chassisColor,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 105,
                  child: Container(
                    width: 3,
                    height: 34,
                    decoration: BoxDecoration(
                      color: chassisColor,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  decoration: BoxDecoration(
                    color: chassisColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.22 : 0.06),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 8,
                    bottom: 0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: phoneScreenBg,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(34),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(34),
                      ),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              item.imageAsset,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildInnerScreen(context, pageIndex);
                              },
                            ),
                          ),
                          Positioned(
                            top: 12,
                            child: Container(
                              height: 11,
                              width: 11,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInnerScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _buildFocusTimerMockup(context);
      case 1:
        return _buildBlockerMockup(context);
      case 2:
        return _buildHabitsMockup(context);
      case 3:
      default:
        return _buildAIMultiplayerMockup(context);
    }
  }

  Widget _buildFocusTimerMockup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 38),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.lavenderSoft(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.book_copy, size: 12, color: AppColors.primaryAccent(context)),
                const SizedBox(width: 4),
                Text(
                  'Deep Mathematics',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccent(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const FocusOrbWidget(size: 80),
          const SizedBox(height: 16),
          Text(
            '25:00',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary(context),
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Deep Flow Session 1 of 4',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: AppColors.textSecondary(context),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border(context), width: 0.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.music_copy, size: 14, color: AppColors.primaryAccent(context)),
                const SizedBox(width: 6),
                Text(
                  'Rain Soundscape Active',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlockerMockup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 38),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.lavenderSoft(context),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(Iconsax.shield_cross_copy, color: AppColors.primaryAccent(context), size: 26),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Stay with your focus',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Instagram Reels Blocked',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: AppColors.textSecondary(context),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border(context), width: 0.8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Session Shield',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    Text(
                      '35m Remaining',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryAccent(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 6,
                    backgroundColor: AppColors.border(context),
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryAccent(context)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryAccent(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Take 3 Deep Breaths',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitsMockup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 38),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Disciplines",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary(context),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.lavenderSoft(context),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.flash_copy, color: AppColors.warningLight, size: 12),
                    const SizedBox(width: 3),
                    Text(
                      '14 Days',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryAccent(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildHabitRow(context, 'Study Physics 2h', 'Completed', true, Iconsax.book_copy),
          const SizedBox(height: 8),
          _buildHabitRow(context, 'Read 25 Pages', 'Completed', true, Iconsax.document_copy),
          const SizedBox(height: 8),
          _buildHabitRow(context, 'Evening Meditation', 'Scheduled 9 PM', false, Iconsax.sun_1_copy),
          const SizedBox(height: 8),
          _buildHabitRow(context, 'Hydration Goal (2.5L)', 'In Progress', false, Iconsax.cup_copy),
        ],
      ),
    );
  }

  Widget _buildHabitRow(BuildContext context, String title, String subtitle, bool completed, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary(context),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border(context), width: 0.8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: completed ? AppColors.success(context).withValues(alpha: 0.15) : AppColors.surface(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 14,
              color: completed ? AppColors.success(context) : AppColors.textSecondary(context),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            completed ? Iconsax.tick_circle_copy : Iconsax.record_circle_copy,
            size: 16,
            color: completed ? AppColors.success(context) : AppColors.textTertiary(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAIMultiplayerMockup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 38),
          Row(
            children: [
              Icon(Iconsax.magicpen_copy, size: 14, color: AppColors.primaryAccent(context)),
              const SizedBox(width: 6),
              Text(
                'AI Attention Insights',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary(context),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border(context), width: 0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Optimal Peak Window: 7:00 – 9:30 PM',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '+28% higher retention when studying during this window.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9.5,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lavenderSoft(context),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryAccent(context).withValues(alpha: 0.25), width: 0.8),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.successLight,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '42 Focusers in "GATE 2027 Sprint"',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ),
                Icon(Iconsax.arrow_right_3_copy, size: 12, color: AppColors.primaryAccent(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
