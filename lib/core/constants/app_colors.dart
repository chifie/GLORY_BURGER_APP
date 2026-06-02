import 'package:flutter/material.dart';

/// App color constants for Glory Burger's ketchup-and-mustard brand system.
/// These colors are used throughout the app for consistent branding.
class AppColors {
  AppColors._();

  // ── Primary Brand Colors ──────────────────────────────────────
  /// Burger Red - primary actions, branding, gradients.
  static const Color primaryRed = Color(0xFFD6232A);

  /// Burger Orange - gradient accents and secondary branding.
  static const Color burgerOrange = Color(0xFFE85D26);

  /// Darker red variant - used for pressed states.
  static const Color darkRed = Color(0xFFAA171D);

  /// Burger Yellow - highlights, badges, stars, accents.
  static const Color accentGold = Color(0xFFFFCC00);

  /// Deep dark gold for pressed states
  static const Color darkGold = Color(0xFFD6A600);

  // ── Neutral Palette ───────────────────────────────────────────
  /// Pure white — backgrounds, cards
  static const Color white = Color(0xFFFFFFFF);

  /// Burger Cream - light section backgrounds.
  static const Color offWhite = Color(0xFFFFFBEB);

  /// Light grey — dividers, disabled fills
  static const Color lightGrey = Color(0xFFE8E8E8);

  /// Medium grey — secondary text
  static const Color mediumGrey = Color(0xFF9E9E9E);

  /// Burger Dark - primary text, deep surfaces.
  static const Color darkCharcoal = Color(0xFF18181B);

  /// Near-black — body text emphasis
  static const Color nearBlack = Color(0xFF1A1A1A);

  // ── Semantic Colors ───────────────────────────────────────────
  /// Success green — delivered status
  static const Color successGreen = Color(0xFF22C55E);

  /// Warning orange — preparing / on-delivery status
  static const Color warningOrange = Color(0xFFFF9800);

  /// Info blue — pending status
  static const Color infoBlue = Color(0xFF2196F3);

  /// Error red — remove / error states
  static const Color errorRed = Color(0xFFD32F2F);

  // ── Gradient Definitions ──────────────────────────────────────
  /// Brand gradient from Burger Red to Burger Orange.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryRed, burgerOrange],
  );

  /// Backward-compatible alias for existing widgets.
  static const LinearGradient redGradient = brandGradient;

  /// Gold accent gradient
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGold, darkGold],
  );

  /// Yellow-white-yellow text highlight gradient.
  static const LinearGradient textHighlightGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [accentGold, white, accentGold],
  );

  static Color redGlow([double alpha = 0.3]) =>
      primaryRed.withValues(alpha: alpha);

  static Color yellowGlow([double alpha = 0.3]) =>
      accentGold.withValues(alpha: alpha);
}
