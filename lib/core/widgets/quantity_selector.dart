import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

/// A compact quantity selector with minus / plus buttons and a count display.
/// Used in the Food Details and Cart screens.
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final bool compact;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = compact ? 30.0 : 38.0;
    final fontSize = compact ? 14.0 : 16.0;
    final iconSize = compact ? 16.0 : 20.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease button
          _buildButton(
            icon: Icons.remove,
            size: buttonSize,
            iconSize: iconSize,
            onTap: quantity > AppConstants.minCartQuantity ? onDecrease : null,
          ),

          // Quantity display
          Container(
            width: compact ? 36 : 44,
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.darkCharcoal,
              ),
            ),
          ),

          // Increase button
          _buildButton(
            icon: Icons.add,
            size: buttonSize,
            iconSize: iconSize,
            onTap: quantity < AppConstants.maxCartQuantity ? onIncrease : null,
          ),
        ],
      ),
    );
  }

  /// Builds an individual +/- button
  Widget _buildButton({
    required IconData icon,
    required double size,
    required double iconSize,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: onTap != null ? AppColors.primaryRed : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: onTap != null ? AppColors.white : AppColors.mediumGrey,
        ),
      ),
    );
  }
}
