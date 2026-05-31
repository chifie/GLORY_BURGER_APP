# Glory Burger 🍔

A modern food ordering mobile app built with **Flutter** and **Dart**, featuring a KFC-inspired red, white, and dark charcoal color palette.

---

## 🏗️ Architecture Overview

### Feature-First Architecture

Glory Burger uses a **Feature-First Architecture** (also called feature-based or domain-based architecture). This means the code is organized by business feature rather than by technical layer. Each feature is self-contained with its own screens, widgets, and logic.

### Why Feature-First?

| Benefit | Explanation |
|---------|-------------|
| **Scalability** | Adding new features doesn't bloat existing ones |
| **Team Collaboration** | Teams can own entire features independently |
| **Discoverability** | All code for a feature lives in one place |
| **Maintainability** | Changes are localized to specific feature folders |
| **Reusability** | Shared core widgets are separated from feature-specific ones |

---

## 📁 Folder Structure (Detailed)

```
lib/
├── core/                          # Shared code used across ALL features
│   ├── constants/
│   │   ├── app_colors.dart        # KFC-inspired color palette (red, white, charcoal)
│   │   └── app_constants.dart     # App-wide values (currency, durations, limits)
│   ├── theme/
│   │   └── app_theme.dart         # Material Design 3 theme configuration
│   ├── widgets/                   # Reusable widgets shared across features
│   │   ├── custom_button.dart     # Primary/outlined action button
│   │   ├── custom_text_field.dart # Styled form input field
│   │   ├── food_card.dart         # Horizontal food item display card
│   │   ├── category_chip.dart     # Category filter chip with icons
│   │   ├── quantity_selector.dart # +/- quantity control
│   │   └── app_bottom_nav_bar.dart# Bottom navigation with cart badge
│   └── utils/
│       └── helpers.dart           # Formatting, validation, utility functions
│
├── features/                      # Feature modules (one folder per feature)
│   ├── splash/
│   │   └── splash_screen.dart     # Animated splash → auto-navigate after 3s
│   ├── home/
│   │   ├── home_screen.dart       # Main landing page with banner, search, categories
│   │   └── widgets/               # Home-specific widgets (not shared)
│   │       ├── banner_widget.dart      # Promotional banner
│   │       ├── category_list.dart      # Horizontal category chips
│   │       ├── popular_foods.dart      # Popular items horizontal list
│   │       └── search_bar_widget.dart  # Search input field
│   ├── food_details/
│   │   └── food_details_screen.dart # Full item details with add-to-cart
│   ├── cart/
│   │   └── cart_screen.dart        # Shopping cart with quantity controls
│   ├── checkout/
│   │   └── checkout_screen.dart    # Delivery info + order placement
│   ├── orders/
│   │   └── orders_screen.dart      # Order history with status tracker
│   └── profile/
│       └── profile_screen.dart     # User profile with edit toggle
│
├── models/                        # Data models (pure Dart classes)
│   ├── food_item.dart             # Food item model with full details
│   ├── cart_item.dart             # Cart item = food + quantity
│   ├── order.dart                 # Order with status tracking
│   ├── category.dart              # Food category
│   ├── user_profile.dart          # User profile information
│   └── mock_data.dart             # All mock/local data (18 food items)
│
├── providers/                     # State management (Provider pattern)
│   ├── food_provider.dart         # Food catalog, filtering, search
│   ├── cart_provider.dart         # Cart operations, totals calculation
│   ├── order_provider.dart        # Order placement, status simulation
│   └── profile_provider.dart      # User profile CRUD
│
├── routes/                        # Navigation configuration
│   ├── app_routes.dart            # Named route constants
│   └── route_generator.dart       # Route → Screen mapping with arguments
│
└── main.dart                      # App entry point + Provider setup
```

---

## 🔄 Data Flow

```
User Action (UI)
      ↓
Widget calls Provider method
      ↓
Provider updates state → notifyListeners()
      ↓
Consumer/Watch widgets rebuild
      ↓
UI reflects new state
```

### State Management with Provider

Each feature has its own Provider class that extends `ChangeNotifier`:

| Provider | Manages | Key Methods |
|----------|---------|-------------|
| `FoodProvider` | Food catalog, categories, search | `loadFoods()`, `setCategory()`, `setSearchQuery()` |
| `CartProvider` | Shopping cart items & totals | `addToCart()`, `removeFromCart()`, `increaseQuantity()` |
| `OrderProvider` | Order history & status | `placeOrder()`, status simulation |
| `ProfileProvider` | User profile data | `updateProfile()`, `toggleEditing()` |

Widgets consume state using:
- `Consumer<T>()` — rebuilds a subtree when state changes
- `context.watch<T>()` — listens and rebuilds
- `context.read<T>()` — accesses without listening

---

## 🎨 Color Palette (KFC-Inspired)

| Color | Hex | Usage |
|-------|-----|-------|
| Primary Red | `#E4002B` | Buttons, headers, accents, branding |
| Dark Red | `#B8001F` | Gradients, pressed states |
| Accent Gold | `#FFC72C` | Highlights, badges, stars |
| White | `#FFFFFF` | Backgrounds, cards |
| Off White | `#F8F8F8` | Subtle backgrounds |
| Dark Charcoal | `#202124` | Primary text |
| Medium Grey | `#9E9E9E` | Secondary text |
| Light Grey | `#E8E8E8` | Dividers, borders |

---

## 🧭 Navigation Flow

```
App Launch
    ↓
Splash Screen (3 seconds)
    ↓
App Shell (Bottom Navigation)
    ├── Home Tab ─────────→ Food Details → Add to Cart
    ├── Cart Tab ─────────→ Checkout → Order Placed!
    ├── Orders Tab ───────→ Status Tracker
    └── Profile Tab ──────→ Edit Profile
```

---

## 📦 Getting Started

### Prerequisites
- Flutter SDK 3.2.0 or later
- Dart SDK 3.2.0 or later

### Installation

```bash
# 1. Navigate to the project directory
cd glory_burger

# 2. Get dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 🧪 Key Design Decisions

### 1. IndexedStack for Tab Navigation
The `AppShell` uses `IndexedStack` instead of switching widgets directly. This preserves the scroll position and state of each tab when switching.

### 2. Feature-Scoped Widgets
The `home/widgets/` folder contains widgets only used by the Home screen. This prevents the `core/widgets/` folder from becoming a dumping ground for all widgets.

### 3. Mock Data as a Static Class
`MockData` is a static class with pre-defined food items. In production, this would be replaced with API calls in the Provider classes.

### 4. Order Status Simulation
For demo purposes, `OrderProvider` automatically progresses order statuses using `Future.delayed`. In a real app, this would come from WebSocket events or polling.

### 5. Cart Badge on Navigation
The bottom nav bar reacts to `CartProvider` changes, showing a gold badge with the item count on the cart icon.

### 6. Free Delivery Threshold
Cart totals automatically calculate delivery fees, with free delivery above 25,000 TZS — a common pattern for food delivery apps.

---

## 📱 Screens Overview

| Screen | Key Features |
|--------|-------------|
| **Splash** | Logo animation, auto-navigation after 3 seconds |
| **Home** | Banner, search, category filters, popular items, full menu grid |
| **Food Details** | Full item info, rating, quantity selector, add to cart |
| **Cart** | Item list, swipe-to-delete, quantity controls, order summary |
| **Checkout** | Form validation, order summary, place order with confirmation dialog |
| **Orders** | Order history, visual status tracker (4 steps), status badges |
| **Profile** | Avatar with initials, edit toggle, personal info, app info |

---

## 🛠️ Tech Stack

- **Flutter** 3.x (latest stable)
- **Dart** 3.x (latest stable)
- **Provider** for state management
- **Material Design 3** theming
- **Null safety** enabled
- **Mock/local data** only (no backend)

---

*Glory Burger — Taste the Glory! 🔥🍔*
