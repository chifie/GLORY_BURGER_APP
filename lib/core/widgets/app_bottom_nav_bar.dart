import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Custom animated bottom navigation bar for the main app shell.
/// Displays Home, Cart, Orders, and Profile tabs with badge support,
/// smooth animations, and a modern design.
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int cartItemCount;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartItemCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkCharcoal.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _NavItem(
                index: 0,
                currentIndex: currentIndex,
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Home',
                onTap: () => onTap(0),
              ),
              _CartNavItem(
                index: 1,
                currentIndex: currentIndex,
                cartItemCount: cartItemCount,
                onTap: () => onTap(1),
              ),
              _NavItem(
                index: 2,
                currentIndex: currentIndex,
                icon: Icons.receipt_long_outlined,
                activeIcon: Icons.receipt_long_rounded,
                label: 'Orders',
                onTap: () => onTap(2),
              ),
              _NavItem(
                index: 3,
                currentIndex: currentIndex,
                icon: Icons.person_outline,
                activeIcon: Icons.person_rounded,
                label: 'Profile',
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single animated navigation item
class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              scale: isActive ? 1.15 : 1.0,
              child: Icon(
                isActive ? activeIcon : icon,
                color: isActive ? AppColors.primaryRed : AppColors.mediumGrey,
                size: 24,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primaryRed : AppColors.mediumGrey,
              ),
              child: Text(label),
            ),
            // Active indicator dot
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              width: isActive ? 20 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryRed : Colors.transparent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The Cart navigation item with a prominent badge
class _CartNavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final int cartItemCount;
  final VoidCallback onTap;

  const _CartNavItem({
    required this.index,
    required this.currentIndex,
    required this.cartItemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              scale: isActive ? 1.15 : 1.0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    isActive
                        ? Icons.shopping_cart_rounded
                        : Icons.shopping_cart_outlined,
                    color: isActive
                        ? AppColors.primaryRed
                        : AppColors.mediumGrey,
                    size: 24,
                  ),
                  // Cart badge
                  if (cartItemCount > 0)
                    Positioned(
                      right: -10,
                      top: -6,
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.elasticOut,
                        scale: 1.0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.accentGold,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            cartItemCount > 99 ? '99+' : '$cartItemCount',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: AppColors.nearBlack,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primaryRed : AppColors.mediumGrey,
              ),
              child: const Text('Cart'),
            ),
            // Active indicator dot
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              width: isActive ? 20 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryRed : Colors.transparent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
