import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class CurvedTopSheetClipper extends CustomClipper<Path> {
  final double arcHeight;
  const CurvedTopSheetClipper({this.arcHeight = 32});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, arcHeight);
    path.quadraticBezierTo(size.width / 2, 0, size.width, arcHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CurvedTopSheetClipper oldClipper) =>
      oldClipper.arcHeight != arcHeight;
}

class AppCurvedBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final double? height;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final EdgeInsetsGeometry contentPadding;
  final Color? backgroundColor;

  const AppCurvedBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.height,
    this.showCloseButton = true,
    this.onClose,
    this.contentPadding = const EdgeInsets.fromLTRB(24, 46, 24, 24),
    this.backgroundColor,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    String? subtitle,
    double? height,
    bool showCloseButton = true,
    VoidCallback? onClose,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(24, 46, 24, 24),
    Color? backgroundColor,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    HapticFeedback.lightImpact();
    return Get.bottomSheet<T>(
      AppCurvedBottomSheet(
        title: title,
        subtitle: subtitle,
        height: height,
        showCloseButton: showCloseButton,
        onClose: onClose,
        contentPadding: contentPadding,
        backgroundColor: backgroundColor,
        child: child,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final resolvedBackgroundColor = backgroundColor ??
        (isDark ? const Color(0xFF141418) : Colors.white);

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          margin: const EdgeInsets.only(top: 24),
          child: ClipPath(
            clipper: const CurvedTopSheetClipper(arcHeight: 32),
            child: Container(
              decoration: BoxDecoration(
                color: resolvedBackgroundColor,
              ),
              child: SafeArea(
                top: false,
                bottom: true,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Padding(
                    padding: contentPadding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null) ...[
                          Text(
                            title!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary(context),
                              letterSpacing: -0.3,
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: AppColors.textSecondary(context),
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                          const SizedBox(height: 18),
                        ],
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (showCloseButton)
          Positioned(
            top: -20,
            child: GestureDetector(
              onTap: onClose ?? () => Get.back(),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [
                                const Color(0xFF282832).withValues(alpha: 0.90),
                                const Color(0xFF181820).withValues(alpha: 0.70),
                              ]
                            : [
                                Colors.white.withValues(alpha: 0.88),
                                Colors.white.withValues(alpha: 0.45),
                              ],
                      ),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF383846)
                            : Colors.white.withValues(alpha: 0.85),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: AppColors.textPrimary(context),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
