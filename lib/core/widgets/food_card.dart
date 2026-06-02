import 'package:flutter/material.dart';

import '../../models/food_item.dart';
import '../constants/app_colors.dart';
import 'brand_motion.dart';

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
    return PressScale(
      onTap: onTap,
      child: Hero(
        tag: 'food_${food.id}',
        child: Container(
          width: 170,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.redGlow(0.16),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: GlassSurface(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _FoodImage(food: food)),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          PulseGlow(
                            minBlur: 4,
                            maxBlur: 10,
                            borderRadius: BorderRadius.circular(999),
                            child: PressScale(
                              onTap: onAddToCart,
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  gradient: AppColors.brandGradient,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                  size: 18,
                                ),
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
      ),
    );
  }
}

class _FoodImage extends StatelessWidget {
  final FoodItem food;

  const _FoodImage({required this.food});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accentGold.withValues(alpha: 0.2),
                  AppColors.burgerOrange.withValues(alpha: 0.08),
                ],
              ),
            ),
          ),
          if (food.imageUrl.isNotEmpty)
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.65,
                heightFactor: 0.82,
                child: FloatingImage(
                  child: Image.asset(
                    food.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => _PlaceholderIcon(food: food),
                  ),
                ),
              ),
            )
          else
            _PlaceholderIcon(food: food),
          if (food.isPopular)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradient,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: AppColors.accentGold,
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
    );
  }
}

class _PlaceholderIcon extends StatelessWidget {
  final FoodItem food;

  const _PlaceholderIcon({required this.food});

  @override
  Widget build(BuildContext context) {
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
