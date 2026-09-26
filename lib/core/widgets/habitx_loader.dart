import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'focus_orb_widget.dart';

class HabitXLoaderPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color sweepColor;
  final double strokeWidth;

  const HabitXLoaderPainter({
    required this.progress,
    required this.trackColor,
    required this.sweepColor,
    this.strokeWidth = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    final sweepPaint = Paint()
      ..color = sweepColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final startAngle = progress * 2 * math.pi;
    const sweepAngle = math.pi * 0.95;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      sweepPaint,
    );
  }

  @override
  bool shouldRepaint(covariant HabitXLoaderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class HabitXLoader extends StatefulWidget {
  final double size;
  final String? message;
  final Color? color;

  const HabitXLoader({
    super.key,
    this.size = 64,
    this.message,
    this.color,
  });

  static void show({String? message}) {
    if (Get.isDialogOpen ?? false) return;
    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? const Color(0xFF16161B) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Get.isDarkMode ? const Color(0xFF282834) : const Color(0xFFE8E8EE),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HabitXLoader(size: 56),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode ? Colors.white : const Color(0xFF111113),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.45),
    );
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  State<HabitXLoader> createState() => _HabitXLoaderState();
}

class _HabitXLoaderState extends State<HabitXLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final primaryColor = widget.color ?? AppColors.primaryAccent(context);
    final trackColor = isDark
        ? const Color(0xFF242430)
        : AppColors.lavenderSoftLight.withValues(alpha: 0.6);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              FocusOrbWidget(
                size: widget.size * 0.44,
                isPulsing: true,
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(widget.size, widget.size),
                    painter: HabitXLoaderPainter(
                      progress: _controller.value,
                      trackColor: trackColor,
                      sweepColor: primaryColor,
                      strokeWidth: widget.size > 50 ? 3.0 : 2.2,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        if (widget.message != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.message!,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary(context),
            ),
          ),
        ],
      ],
    );
  }
}
