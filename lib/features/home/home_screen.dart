import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/brand_motion.dart';
import '../../models/food_item.dart';
import '../../providers/food_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/notification_provider.dart';
import '../../routes/app_routes.dart';
import 'widgets/banner_widget.dart';
import 'widgets/category_list.dart';
import 'widgets/popular_foods.dart';
import 'widgets/search_bar_widget.dart';

/// Home Screen — the main landing page after splash.
/// Displays a banner, search bar, food categories, popular items,
/// and category-filtered food items.
class HomeScreen extends StatefulWidget {
  final VoidCallback? onMenuTap;

  const HomeScreen({super.key, this.onMenuTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load food data when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FoodProvider>().loadFoods();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      floatingActionButton: PulseGlow(
        borderRadius: BorderRadius.circular(999),
        child: PressScale(
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.cart),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Order Now',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // ── App Bar with Glory Burger branding ────────────────
          SliverAppBar(
            expandedHeight: 60,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primaryRed,
            leading: IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.white,
              ),
              tooltip: 'Menu',
              onPressed: widget.onMenuTap,
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'lib/assets/images/logo.png',
                      width: 28,
                      height: 28,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  AppConstants.appName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            actions: [
              // Notification bell with badge
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Consumer<NotificationProvider>(
                  builder: (context, notifProvider, _) {
                    return Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.notifications);
                          },
                        ),
                        if (notifProvider.unreadCount > 0)
                          Positioned(
                            right: 6,
                            top: 6,
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
                                '${notifProvider.unreadCount}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.nearBlack,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              // Cart icon with badge
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Consumer<CartProvider>(
                  builder: (context, cart, _) {
                    return Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.cart);
                          },
                        ),
                        if (cart.itemCount > 0)
                          Positioned(
                            right: 6,
                            top: 6,
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
                                '${cart.itemCount}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.nearBlack,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),

          // ── Main Content ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // Promotional banner
                const BannerWidget(),

                const SizedBox(height: 16),

                // Search bar
                SearchBarWidget(
                  controller: _searchController,
                  onChanged: (query) {
                    context.read<FoodProvider>().setSearchQuery(query);
                  },
                  onClear: () {
                    context.read<FoodProvider>().clearSearch();
                  },
                ),

                const SizedBox(height: 20),

                // Category chips
                const CategoryList(),

                const SizedBox(height: 20),

                // Popular food items (horizontal scroll)
                const PopularFoods(),

                const SizedBox(height: 20),

                // Category-filtered food items
                Consumer<FoodProvider>(
                  builder: (context, foodProvider, _) {
                    return _buildCategoryFoods(foodProvider);
                  },
                ),

                const SizedBox(height: 100), // Bottom padding for nav bar
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the category-filtered food grid section
  Widget _buildCategoryFoods(FoodProvider foodProvider) {
    if (foodProvider.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryRed),
          ),
        ),
      );
    }

    final foods = foodProvider.filteredFoods;
    final category = foodProvider.selectedCategory;

    // Group foods by sub-category
    final grouped = foodProvider.getFoodsBySubCategory(foods);
    final subCategories = grouped.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Our $category',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.darkCharcoal,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Sub-category sections
        ...subCategories.map((subCategory) {
          final subFoods = grouped[subCategory]!;
          return _buildSubCategorySection(subCategory, subFoods);
        }),
      ],
    );
  }

  /// Builds a sub-category section with a header and horizontally scrollable cards.
  /// Shows 4 items per scroll view, scrolls left/right to reveal more.
  Widget _buildSubCategorySection(String subCategory, List<FoodItem> foods) {
    final iconData = subCategory == 'Classic'
        ? Icons.star
        : subCategory == 'Specialty'
            ? Icons.auto_awesome
            : Icons.workspace_premium;

    // Each card width = (screen width - horizontal padding - gaps for 4 items) / 4
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 16 - 16 - (3 * 8)) / 4; // paddings + gaps
    const cardHeight = 100 + 80; // fixed image height + info area

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sub-category header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  iconData,
                  size: 18,
                  color: AppColors.primaryRed,
                ),
                const SizedBox(width: 8),
                Text(
                  subCategory,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkCharcoal,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryRed.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${foods.length}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryRed,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Horizontally scrollable cards - 4 items visible per scroll
          SizedBox(
            height: cardHeight + 8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < foods.length - 1 ? 8 : 0,
                  ),
                  child: StaggeredEntrance(
                    index: index,
                    child: SizedBox(
                      width: cardWidth,
                      child: _buildGridFoodCard(context, food),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds an individual food card for the horizontal scroll layout.
  /// Uses fixed heights to prevent overflow (no Expanded widgets).
  Widget _buildGridFoodCard(BuildContext context, FoodItem food) {
    return PressScale(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.foodDetails,
          arguments: food.id,
        );
      },
      child: Hero(
        tag: 'food_${food.id}',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.redGlow(0.16),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: GlassSurface(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Food image - fixed height to prevent overflow
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.accentGold.withValues(alpha: 0.22),
                                AppColors.burgerOrange.withValues(alpha: 0.08),
                              ],
                            ),
                          ),
                        ),
                      if (food.imageUrl.isNotEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                food.imageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Icon(
                                  _getCategoryIcon(food.category),
                                  size: 28,
                                  color: AppColors.primaryRed
                                      .withValues(alpha: 0.4),
                                ),
                              ),
                            ),
                          )
                        else
                          Center(
                            child: Icon(
                              _getCategoryIcon(food.category),
                              size: 28,
                              color: AppColors.primaryRed
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                        // Popular badge
                        if (food.isPopular)
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
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
                                    size: 8,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    'POPULAR',
                                    style: TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white,
                                      letterSpacing: 0.3,
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

                // Food info - fixed padding, no Expanded
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        food.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
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
                            size: 9,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${food.rating}',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkCharcoal,
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
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryRed,
                              ),
                            ),
                          ),
                          PulseGlow(
                            minBlur: 3,
                            maxBlur: 8,
                            borderRadius: BorderRadius.circular(999),
                            child: PressScale(
                              onTap: () {
                                context
                                    .read<CartProvider>()
                                    .addToCart(food);
                                context
                                    .read<NotificationProvider>()
                                    .notifyItemAddedToCart(food.name);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${food.name} added to cart'),
                                    duration: AppConstants.snackbarDuration,
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  gradient: AppColors.brandGradient,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                  size: 12,
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

  /// Returns an icon for each food category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Burgers':
        return Icons.lunch_dining;
      default:
        return Icons.restaurant;
    }
  }
}
