import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'brand_motion.dart';

/// A reusable primary action button with the Glory Burger branding.
/// Supports loading state, icon, and custom sizing.
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 52,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    // Choose the appropriate button style based on configuration
    final buttonStyle = isOutlined
        ? OutlinedButton.styleFrom(
            minimumSize: Size(width ?? double.infinity, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            side: BorderSide(
              color: backgroundColor ?? AppColors.primaryRed,
              width: 1.5,
            ),
            foregroundColor: textColor ?? AppColors.primaryRed,
          )
        : ElevatedButton.styleFrom(
            minimumSize: Size(width ?? double.infinity, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            backgroundColor: backgroundColor ?? AppColors.primaryRed,
            foregroundColor: textColor ?? AppColors.white,
            elevation: 0,
          );

    // Build the child widget (icon + label or loading spinner)
    Widget child;
    if (isLoading) {
      child = SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined ? AppColors.primaryRed : AppColors.white,
          ),
        ),
      );
    } else if (icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      );
    } else {
      child = Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );
    }

    if (isOutlined) {
      return PressScale(
        onTap: isLoading ? null : onPressed,
        child: AbsorbPointer(
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: buttonStyle,
            child: child,
          ),
        ),
      );
    }

    return PulseGlow(
      borderRadius: BorderRadius.circular(borderRadius),
      child: PressScale(
        onTap: isLoading ? null : onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: backgroundColor == null ? AppColors.brandGradient : null,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: AbsorbPointer(
            child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: buttonStyle.copyWith(
                backgroundColor:
                    const WidgetStatePropertyAll(Colors.transparent),
                shadowColor: const WidgetStatePropertyAll(Colors.transparent),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
