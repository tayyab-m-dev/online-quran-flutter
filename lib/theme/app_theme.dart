
import 'package:flutter/material.dart';

class AppTheme {
  static const Color forestGreen = Color(0xFF174D3A);
  static const Color warmCream = Color(0xFFF7F3E8);
  static const Color softGold = Color(0xFFD5B56D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF202820);
  static const Color textMuted = Color(0xFF72776F);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: warmCream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: forestGreen,
        primary: forestGreen,
        secondary: softGold,
        surface: white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: warmCream,
        foregroundColor: forestGreen,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: white,
        indicatorColor: softGold.withValues(alpha: 0.30),
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: forestGreen,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
