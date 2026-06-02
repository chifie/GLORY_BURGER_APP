import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../models/food_item.dart';

/// A visually attractive card displaying a food item with image, name,
/// price, and a quick "add to cart" button. Used on the Home screen.
class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'food_${food.id}',
        child: Container(
          width: 170,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkCharcoal.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Food Image ──────────────────────────────────
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background color
                      Container(color: AppColors.offWhite),

                      // Actual image
                      if (food.imageUrl.isNotEmpty)
                        Image.asset(
                          food.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholderIcon(),
                        )
                      else
                        _buildPlaceholderIcon(),

                      // Popular badge
                      if (food.isPopular)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.primaryRed.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: AppColors.white,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  'POPULAR',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // ── Food Info ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkCharcoal,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Rating row
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.accentGold,
                          size: 12,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${food.rating}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkCharcoal,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${food.reviewCount})',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.mediumGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Price + Add button row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${food.price.toInt()} TZS',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryRed,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: AppColors.primaryRed,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryRed
                                      .withValues(alpha: 0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Placeholder icon when no image is available
  Widget _buildPlaceholderIcon() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getCategoryIcon(food.category),
            size: 44,
            color: AppColors.primaryRed.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 4),
          Text(
            food.category,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.mediumGrey.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Burgers':
        return Icons.lunch_dining;
      default:
        return Icons.restaurant;
    }
  }
}
