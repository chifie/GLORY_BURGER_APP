# 🍔 Glory Burger App

A modern food ordering mobile app built with **Flutter**. Browse the menu, add items to your cart, and place orders — all from your Android device.

---

## 📱 Screenshots

> Auth · Home · Menu · Cart · Checkout · Orders

---

## ✨ Features

- 🔐 User registration and login with JWT authentication
- 🍔 Browse food menu by category (Burgers, Drinks, Sides, Desserts)
- 🔍 Search foods by name or description
- ⭐ View popular food items
- 🛒 Add, update, and remove items from cart
- 📦 Place orders with delivery details and M-Pesa payment
- 📋 View order history
- 👤 User profile management
- 🔔 In-app notifications

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart) |
| State Management | Provider |
| HTTP Client | http |
| Local Storage | shared_preferences |
| Backend API | NestJS REST API |
| Database | PostgreSQL (via backend) |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed
- Android device or emulator
- Backend API running (see [GloryBurger_App_Backend](https://github.com/chifie/GloryBurger_App_Backend))

### Installation

```bash
# Clone the repository
git clone https://github.com/chifie/GLORY_BURGER_APP.git
cd GLORY_BURGER_APP

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Configuration

In `lib/core/api/api_client.dart`, set the base URL to your backend server:

```dart
// For physical Android device (same WiFi as your computer):
static const String baseUrl = "http://YOUR_COMPUTER_IP:3000/api/v1";

// For Android emulator:
static const String baseUrl = "http://10.0.2.2:3000/api/v1";
```

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── api/          # API client
│   ├── constants/    # Colors, constants
│   ├── services/     # Auth, Food, Cart, Order services
│   ├── utils/        # Helpers
│   └── widgets/      # Shared widgets
├── features/
│   ├── auth/         # Login & Register screens
│   ├── home/         # Home screen & widgets
│   ├── food_details/ # Food detail screen
│   ├── cart/         # Cart screen
│   ├── checkout/     # Checkout screen
│   ├── orders/       # Order history screen
│   ├── profile/      # User profile screen
│   ├── notifications/# Notifications screen
│   └── splash/       # Splash screen
├── models/           # Data models
├── providers/        # State management
└── routes/           # App navigation
```

---

## 🔗 Backend

This app communicates with the Glory Burger REST API built with NestJS.

👉 [GloryBurger_App_Backend](https://github.com/chifie/GloryBurger_App_Backend)

---

## 👩‍💻 Author

**Levina Chifie**  
Flutter & Web Developer  
Intern @ [Oddity Tech Solution Ltd](https://github.com/chifie) · Dar es Salaam, Tanzania  
St. Joseph College of Engineering and Technology

---

## 📄 License

This project is for educational and portfolio purposes.
