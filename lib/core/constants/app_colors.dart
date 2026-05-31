import 'package:flutter/material.dart';

/// App color constants inspired by KFC's iconic red, white, and dark palette.
/// These colors are used throughout the app for consistent branding.
class AppColors {
  AppColors._();

  // ── Primary Brand Colors ──────────────────────────────────────
  /// KFC-style bold red — used for primary buttons, headers, accents
  static const Color primaryRed = Color(0xFFE4002B);

  /// Darker red variant — used for pressed states, gradients
  static const Color darkRed = Color(0xFFB8001F);

  /// Golden / amber accent — used for highlights, badges, stars
  static const Color accentGold = Color(0xFFFFC72C);

  /// Deep dark gold for pressed states
  static const Color darkGold = Color(0xFFD4A017);

  // ── Neutral Palette ───────────────────────────────────────────
  /// Pure white — backgrounds, cards
  static const Color white = Color(0xFFFFFFFF);

  /// Off-white — subtle backgrounds
  static const Color offWhite = Color(0xFFF8F8F8);

  /// Light grey — dividers, disabled fills
  static const Color lightGrey = Color(0xFFE8E8E8);

  /// Medium grey — secondary text
  static const Color mediumGrey = Color(0xFF9E9E9E);

  /// Dark charcoal — primary text
  static const Color darkCharcoal = Color(0xFF202124);

  /// Near-black — body text emphasis
  static const Color nearBlack = Color(0xFF1A1A1A);

  // ── Semantic Colors ───────────────────────────────────────────
  /// Success green — delivered status
  static const Color successGreen = Color(0xFF4CAF50);

  /// Warning orange — preparing / on-delivery status
  static const Color warningOrange = Color(0xFFFF9800);

  /// Info blue — pending status
  static const Color infoBlue = Color(0xFF2196F3);

  /// Error red — remove / error states
  static const Color errorRed = Color(0xFFD32F2F);

  // ── Gradient Definitions ──────────────────────────────────────
  /// Primary red gradient (top-to-bottom)
  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryRed, darkRed],
  );

  /// Gold accent gradient
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGold, darkGold],
  );
}
