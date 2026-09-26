import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;
  final bool isOutlined;
  final Widget? prefixIcon;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
    this.isOutlined = false,
    this.prefixIcon,
    this.width,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    BorderSide borderSide;

    if (isOutlined) {
      backgroundColor = AppColors.transparent;
      textColor = AppColors.darkTextPrimary;
      borderSide = const BorderSide(color: AppColors.darkBorder, width: 1);
    } else if (isSecondary) {
      backgroundColor = AppColors.darkSurfaceSecondary;
      textColor = AppColors.darkTextPrimary;
      borderSide = const BorderSide(color: AppColors.darkBorder, width: 1);
    } else {
      backgroundColor = AppColors.lavenderLight;
      textColor = AppColors.darkBackground;
      borderSide = BorderSide.none;
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Material(
        color: onPressed == null || isLoading
            ? backgroundColor.withValues(alpha: 0.5)
            : backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: borderSide,
        ),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (prefixIcon != null) ...[
                        prefixIcon!,
                        const SizedBox(width: 8),
                      ],
                      Text(
                        text,
                        style: AppTypography.button.copyWith(color: textColor),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
