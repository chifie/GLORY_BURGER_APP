import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Restaurant banner widget shown at the top of the Home screen.
/// Displays the burger image full-width, large and attractive with a subtle pulse animation.
class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: child,
        );
      },
      child: Container(
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
      ),
    );
  }
}


