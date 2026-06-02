import 'food_item.dart';
import 'category.dart';

/// Mock data repository for the entire app.
/// All food items, categories, and initial data are defined here.
/// In a production app, this would be replaced with API calls.
class MockData {
  MockData._();

  // ── Categories ────────────────────────────────────────────────
  static const List<Category> categories = [
    Category(
      id: 'cat_1',
      name: 'Burgers',
      icon: 'lib/assets/images/burgers/Classicburger.jpg',
    ),
  ];

  // ── Food Items ────────────────────────────────────────────────
  static const List<FoodItem> foodItems = [
    // ── Burgers ─────────────────────────────
    FoodItem(
      id: 'food_1',
      name: 'Glory Classic Burger',
      description:
          'Our signature flame-grilled beef patty with fresh lettuce, tomatoes, pickles, and our secret Glory sauce on a toasted sesame bun.',
      price: 12000,
      category: 'Burgers',
      rating: 4.8,
      reviewCount: 234,
      isPopular: true,
      imageUrl: 'lib/assets/images/burgers/Classicburger.jpg',
    ),
    FoodItem(
      id: 'food_2',
      name: 'Cheese Glory Burger',
      description:
          'Juicy beef patty layered with melted cheese, crisp lettuce, tomatoes, and Glory sauce.',
      price: 15000,
      category: 'Burgers',
      rating: 4.7,
      reviewCount: 176,
      isPopular: true,
      imageUrl: 'lib/assets/images/burgers/cheeseburger.jpg',
    ),
    FoodItem(
      id: 'food_3',
      name: 'Veggie Delight Burger',
      description:
          'Plant-based patty with fresh greens, tomato, and herb aioli on a soft burger bun.',
      price: 13000,
      category: 'Burgers',
      rating: 4.5,
      reviewCount: 88,
      isPopular: true,
      imageUrl: 'lib/assets/images/burgers/Veggieburger.jpg',
    ),
    FoodItem(
      id: 'food_4',
      name: 'Double Stack Burger',
      description:
          'Two beef patties, melted cheddar, caramelized onions, pickles, and smoky house sauce.',
      price: 18000,
      category: 'Burgers',
      rating: 4.9,
      reviewCount: 191,
      isPopular: true,
      imageUrl: 'lib/assets/images/burgers/download.jpeg',
    ),
    FoodItem(
      id: 'food_5',
      name: 'Spicy Flame Burger',
      description:
          'A bold burger with pepper jack cheese, jalapenos, lettuce, and a spicy chili sauce.',
      price: 16000,
      category: 'Burgers',
      rating: 4.6,
      reviewCount: 142,
      isPopular: true,
      imageUrl: 'lib/assets/images/burgers/download (1).jpeg',
    ),
    FoodItem(
      id: 'food_6',
      name: 'BBQ Smoke Burger',
      description:
          'Grilled beef patty with smoky BBQ sauce, cheddar, onions, lettuce, and tomato.',
      price: 17000,
      category: 'Burgers',
      rating: 4.7,
      reviewCount: 128,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/download (2).jpeg',
    ),
    FoodItem(
      id: 'food_7',
      name: 'Crispy Chicken Burger',
      description:
          'Crispy chicken fillet with mayo, lettuce, tomato, and a toasted brioche bun.',
      price: 14500,
      category: 'Burgers',
      rating: 4.5,
      reviewCount: 117,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/download (3).jpeg',
    ),
    FoodItem(
      id: 'food_8',
      name: 'Mushroom Melt Burger',
      description:
          'Beef patty topped with sauteed mushrooms, cheese, lettuce, and creamy garlic sauce.',
      price: 16500,
      category: 'Burgers',
      rating: 4.6,
      reviewCount: 104,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/download (4).jpeg',
    ),
    FoodItem(
      id: 'food_9',
      name: 'Bacon Crunch Burger',
      description:
          'A crunchy, savory burger with bacon-style strips, cheddar, pickles, and house sauce.',
      price: 17500,
      category: 'Burgers',
      rating: 4.8,
      reviewCount: 153,
      isPopular: true,
      imageUrl: 'lib/assets/images/burgers/download (5).jpeg',
    ),
    FoodItem(
      id: 'food_10',
      name: 'Jalapeno Cheese Burger',
      description:
          'Cheesy beef burger with jalapenos, lettuce, tomato, and a creamy pepper sauce.',
      price: 15500,
      category: 'Burgers',
      rating: 4.4,
      reviewCount: 91,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/download (6).jpeg',
    ),
    FoodItem(
      id: 'food_11',
      name: 'Royal Beef Burger',
      description:
          'Premium beef patty, cheddar, fresh vegetables, pickles, and rich Glory sauce.',
      price: 19000,
      category: 'Burgers',
      rating: 4.9,
      reviewCount: 214,
      isPopular: true,
      imageUrl: 'lib/assets/images/burgers/download (7).jpeg',
    ),
    FoodItem(
      id: 'food_12',
      name: 'Honey Mustard Burger',
      description:
          'Tender patty with honey mustard sauce, lettuce, tomato, onions, and melted cheese.',
      price: 15000,
      category: 'Burgers',
      rating: 4.3,
      reviewCount: 76,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/download (8).jpeg',
    ),
    FoodItem(
      id: 'food_13',
      name: 'Street Stack Burger',
      description:
          'A loaded street-style burger with double cheese, pickles, onions, and tangy sauce.',
      price: 18500,
      category: 'Burgers',
      rating: 4.7,
      reviewCount: 133,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/download (9).jpeg',
    ),
    FoodItem(
      id: 'food_14',
      name: 'Garlic Mayo Burger',
      description:
          'Beef patty with garlic mayo, crisp lettuce, tomato, cheese, and toasted bun.',
      price: 14500,
      category: 'Burgers',
      rating: 4.4,
      reviewCount: 86,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/download (10).jpeg',
    ),
    FoodItem(
      id: 'food_15',
      name: 'Mega Glory Burger',
      description:
          'A hearty burger stacked with beef, cheese, lettuce, tomatoes, onions, and sauce.',
      price: 21000,
      category: 'Burgers',
      rating: 4.8,
      reviewCount: 169,
      isPopular: true,
      imageUrl: 'lib/assets/images/burgers/download (11).jpeg',
    ),
    FoodItem(
      id: 'food_16',
      name: 'Classic Grill Burger',
      description:
          'Simple grilled perfection with a seasoned patty, lettuce, tomato, onion, and sauce.',
      price: 12500,
      category: 'Burgers',
      rating: 4.2,
      reviewCount: 62,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/images.jpeg',
    ),
    FoodItem(
      id: 'food_17',
      name: 'Cheddar House Burger',
      description:
          'Cheddar-forward burger with beef, onions, lettuce, tomato, and a creamy house sauce.',
      price: 15500,
      category: 'Burgers',
      rating: 4.5,
      reviewCount: 99,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/images (1).jpeg',
    ),
    FoodItem(
      id: 'food_18',
      name: 'Pepper Sauce Burger',
      description:
          'Beef patty with pepper sauce, cheese, lettuce, tomato, and fresh onions.',
      price: 16000,
      category: 'Burgers',
      rating: 4.4,
      reviewCount: 83,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/images (2).jpeg',
    ),
    FoodItem(
      id: 'food_19',
      name: 'Golden Bun Burger',
      description:
          'A balanced burger with a soft golden bun, seasoned patty, cheese, and fresh salad.',
      price: 14000,
      category: 'Burgers',
      rating: 4.3,
      reviewCount: 74,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/images (3).jpeg',
    ),
    FoodItem(
      id: 'food_20',
      name: 'Tangy Pickle Burger',
      description:
          'Savory beef burger with extra pickles, cheddar, lettuce, onions, and tangy sauce.',
      price: 15000,
      category: 'Burgers',
      rating: 4.5,
      reviewCount: 93,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/images (4).jpeg',
    ),
    FoodItem(
      id: 'food_21',
      name: 'Creamy Onion Burger',
      description:
          'Beef patty with creamy onion sauce, cheese, lettuce, and tomato on a toasted bun.',
      price: 15500,
      category: 'Burgers',
      rating: 4.4,
      reviewCount: 81,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/images (5).jpeg',
    ),
    FoodItem(
      id: 'food_22',
      name: 'Firehouse Burger',
      description:
          'Spicy house burger with chili sauce, cheese, fresh vegetables, and a toasted bun.',
      price: 16500,
      category: 'Burgers',
      rating: 4.6,
      reviewCount: 111,
      isPopular: false,
      imageUrl: 'lib/assets/images/burgers/images (6).jpeg',
    ),
    FoodItem(
      id: 'food_23',
      name: 'Signature Glory Stack',
      description:
          'A signature stacked burger with beef, cheese, lettuce, tomato, pickles, and Glory sauce.',
      price: 20000,
      category: 'Burgers',
      rating: 4.8,
      reviewCount: 158,
      isPopular: true,
      imageUrl: 'lib/assets/images/burgers/images (7).jpeg',
    ),
  ];

  /// Returns food items filtered by category name
  static List<FoodItem> getFoodByCategory(String category) {
    return foodItems.where((item) => item.category == category).toList();
  }

  /// Returns only the popular food items
  static List<FoodItem> get popularItems {
    return foodItems.where((item) => item.isPopular).toList();
  }

  /// Returns food items matching a search query
  static List<FoodItem> searchFood(String query) {
    final lowerQuery = query.toLowerCase();
    return foodItems
        .where((item) =>
            item.name.toLowerCase().contains(lowerQuery) ||
            item.description.toLowerCase().contains(lowerQuery) ||
            item.category.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
