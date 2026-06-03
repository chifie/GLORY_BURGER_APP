import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/brand_motion.dart';

/// Restaurant banner widget shown at the top of the Home screen.
/// Displays a full-width background image with slow rotation animation.
class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredEntrance(
      index: 0,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkCharcoal.withValues(alpha: 0.12),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
            width: double.infinity,
            height: 260,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 2 * math.pi),
              duration: const Duration(seconds: 20),
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: value,
                  child: Image.asset(
                    'lib/assets/images/burgers/background.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                );
              },
              onEnd: () {},
            ),
          ),
        ),
      ),
    );
  }
}


