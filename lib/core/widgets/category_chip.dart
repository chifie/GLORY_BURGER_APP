import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A horizontally scrollable chip selector for food categories.
/// Highlights the selected category in the brand red color.
class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryRed : AppColors.offWhite,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primaryRed : AppColors.lightGrey,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category icon
            _getCategoryIcon(label, isSelected),
            const SizedBox(width: 6),
            // Category label
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.darkCharcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns an appropriate icon for each food category
  Widget _getCategoryIcon(String category, bool isSelected) {
    if (category == 'Burgers') {
      return Image.asset(
        'lib/assets/images/logo.png',
        width: 16,
        height: 16,
        fit: BoxFit.contain,
        color: isSelected ? AppColors.white : null,
      );
    }
    return Icon(
      Icons.restaurant,
      size: 16,
      color: isSelected ? AppColors.white : AppColors.mediumGrey,
    );
  }
}
