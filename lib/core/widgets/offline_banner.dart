import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../services/connectivity_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivityService = Get.find<ConnectivityService>();

    return Obx(() {
      if (connectivityService.isOnline.value) {
        return const SizedBox.shrink();
      }

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: AppColors.warningDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.wifi_square_copy, size: 16, color: AppColors.darkBackground),
            const SizedBox(width: 8),
            Text(
              'Offline Mode Active — Local data is safe',
              style: AppTypography.caption.copyWith(
                color: AppColors.darkBackground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}
