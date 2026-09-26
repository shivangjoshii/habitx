import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class CurvedArcClipper extends CustomClipper<Path> {
  final double dipOffset;
  const CurvedArcClipper({this.dipOffset = 28});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 54);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + dipOffset,
      size.width,
      size.height - 54,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CurvedAuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final bool showActionButton;
  final IconData actionIcon;
  final VoidCallback? onAction;
  final double height;

  const CurvedAuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = false,
    this.onBack,
    this.showActionButton = false,
    this.actionIcon = Icons.help_outline_rounded,
    this.onAction,
    this.height = 280,
  });

  static const String _headerSvgArtwork = '''
<svg width="250" height="270" viewBox="0 0 250 270" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="vStroke" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#FFFFFF" stop-opacity="0.40"/>
      <stop offset="60%" stop-color="#FFFFFF" stop-opacity="0.12"/>
      <stop offset="100%" stop-color="#FFFFFF" stop-opacity="0.0"/>
    </linearGradient>
    <radialGradient id="vGlow" cx="50%" cy="50%" r="50%">
      <stop offset="0%" stop-color="#FFFFFF" stop-opacity="0.22"/>
      <stop offset="70%" stop-color="#FFFFFF" stop-opacity="0.06"/>
      <stop offset="100%" stop-color="#FFFFFF" stop-opacity="0.0"/>
    </radialGradient>
    <linearGradient id="vAccent" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#FFFFFF" stop-opacity="0.25"/>
      <stop offset="100%" stop-color="#FFFFFF" stop-opacity="0.05"/>
    </linearGradient>
  </defs>

  <circle cx="175" cy="115" r="90" fill="url(#vGlow)"/>

  <circle cx="175" cy="115" r="115" stroke="url(#vStroke)" stroke-width="1.2"/>
  <circle cx="175" cy="115" r="85" stroke="url(#vStroke)" stroke-width="1.4"/>
  <circle cx="175" cy="115" r="55" stroke="url(#vStroke)" stroke-width="1.2"/>

  <rect x="147" y="87" width="56" height="56" rx="20" fill="url(#vAccent)" stroke="url(#vStroke)" stroke-width="1.4"/>
  <circle cx="175" cy="115" r="16" fill="url(#vGlow)" stroke="#FFFFFF" stroke-opacity="0.45" stroke-width="1.2"/>
  <circle cx="175" cy="115" r="5" fill="#FFFFFF" fill-opacity="0.90"/>

  <line x1="175" y1="56" x2="175" y2="64" stroke="#FFFFFF" stroke-opacity="0.55" stroke-width="2" stroke-linecap="round"/>
  <line x1="175" y1="166" x2="175" y2="174" stroke="#FFFFFF" stroke-opacity="0.55" stroke-width="2" stroke-linecap="round"/>
  <line x1="116" y1="115" x2="124" y2="115" stroke="#FFFFFF" stroke-opacity="0.55" stroke-width="2" stroke-linecap="round"/>
  <line x1="226" y1="115" x2="234" y2="115" stroke="#FFFFFF" stroke-opacity="0.55" stroke-width="2" stroke-linecap="round"/>

  <path d="M50 150 C95 150, 130 185, 175 185 C210 185, 230 160, 245 140" stroke="url(#vStroke)" stroke-width="1.8" stroke-linecap="round" fill="none"/>
  <path d="M70 170 C110 170, 140 200, 185 200 C215 200, 235 180, 250 165" stroke="url(#vStroke)" stroke-width="1.2" stroke-linecap="round" fill="none"/>

  <path d="M100 48 Q100 54 106 54 Q100 54 100 60 Q100 54 94 54 Q100 54 100 48 Z" fill="#FFFFFF" fill-opacity="0.55"/>
  <path d="M218 52 Q218 57 223 57 Q218 57 218 62 Q218 57 213 57 Q218 57 218 52 Z" fill="#FFFFFF" fill-opacity="0.45"/>
  <path d="M88 110 Q88 114 92 114 Q88 114 88 118 Q88 114 84 114 Q88 114 88 110 Z" fill="#FFFFFF" fill-opacity="0.35"/>

  <circle cx="70" cy="85" r="2.2" fill="#FFFFFF" fill-opacity="0.45"/>
  <circle cx="225" cy="180" r="2.5" fill="#FFFFFF" fill-opacity="0.45"/>
  <circle cx="120" cy="210" r="1.8" fill="#FFFFFF" fill-opacity="0.35"/>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return ClipPath(
      clipper: const CurvedArcClipper(),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [
                    Color(0xFF6B45D8),
                    Color(0xFF5331B8),
                    Color(0xFF381F8C),
                  ]
                : const [
                    Color(0xFFA98AF7),
                    Color(0xFF9B7AF5),
                    Color(0xFF825FE0),
                  ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -30,
                right: -20,
                width: 220,
                height: 220,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.18),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -10,
                right: -25,
                width: 250,
                height: 270,
                child: IgnorePointer(
                  child: FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: SvgPicture.string(
                      _headerSvgArtwork,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      FadeInUp(
                        from: 10,
                        duration: const Duration(milliseconds: 320),
                        child: Text(
                          title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.5,
                            height: 1.18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      FadeInUp(
                        from: 8,
                        duration: const Duration(milliseconds: 340),
                        delay: const Duration(milliseconds: 60),
                        child: Text(
                          subtitle,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            color: Colors.white.withValues(alpha: 0.94),
                            height: 1.38,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 55),
                    ],
                  ),
                ),
              ),
              if (showBackButton)
                Positioned(
                  top: 10,
                  left: 14,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: onBack ?? () => Get.back(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.38),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (showActionButton)
                Positioned(
                  top: 10,
                  right: 14,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () {
                        HapticFeedback.lightImpact();
                        if (onAction != null) {
                          onAction!();
                        }
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.38),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            actionIcon,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
