import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Restaurant banner widget shown at the top of the Home screen.
/// Displays the burger image full-width, large and attractive.
class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      color: Colors.transparent,
      child: Center(
        child: Image.asset(
          'lib/assets/images/burgers/background.png',
          width: double.infinity,
          height: 320,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(
            Icons.lunch_dining_rounded,
            size: 150,
            color: AppColors.primaryRed.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}


