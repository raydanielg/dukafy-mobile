import 'package:flutter/material.dart';

class AppColors {
  // === GRADIENT COLORS (Green Theme) ===
  // Primary Green Gradient
  static const Color primaryGreen = Color(0xFF00C853);
  static const Color primaryGreenLight = Color(0xFF64DD17);
  static const Color primaryGreenDark = Color(0xFF009624);
  static const Color primaryTeal = Color(0xFF00BFA5);
  
  // Legacy aliases for compatibility
  static const Color primaryPurple = Color(0xFF00C853);
  static const Color primaryPink = Color(0xFF64DD17);
  static const Color primaryBlue = Color(0xFF00BFA5);
  static const Color primaryCyan = Color(0xFF00C853);
  
  // Dark Theme Backgrounds
  static const Color darkBackground = Color(0xFF0F0F1F);
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkCard = Color(0xFF252542);
  static const Color darkElevated = Color(0xFF2D2D4A);
  
  // Gradient Lists
  static const List<Color> primaryGradient = [
    Color(0xFF00C853),
    Color(0xFF64DD17),
    Color(0xFF00BFA5),
  ];
  
  static const List<Color> blueGradient = [
    Color(0xFF00BFA5),
    Color(0xFF00C853),
  ];
  
  static const List<Color> cyanGradient = [
    Color(0xFF00C853),
    Color(0xFF64DD17),
  ];
  
  static const List<Color> successGradient = [
    Color(0xFF00C853),
    Color(0xFF64DD17),
  ];
  
  static const List<Color> warningGradient = [
    Color(0xFFFFAB00),
    Color(0xFFFF6D00),
  ];
  
  static const List<Color> errorGradient = [
    Color(0xFFFF5252),
    Color(0xFFFF1744),
  ];
  
  // === ORIGINAL COLORS (Green Theme) ===
  static const Color primary = Color(0xFF00C853);
  static const Color primaryDark = Color(0xFF009624);
  static const Color primaryLight = Color(0xFF64DD17);
  
  static const Color secondary = Color(0xFF00BFA5);
  static const Color secondaryDark = Color(0xFF008E76);
  static const Color secondaryLight = Color(0xFF64FFDA);
  
  static const Color accent = Color(0xFFFFAB00);
  static const Color accentDark = Color(0xFFFF6D00);
  static const Color accentLight = Color(0xFFFFE57F);
  
  // Semantic Colors
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF5252);
  static const Color info = Color(0xFF2196F3);
  
  // Light Theme Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8F9FE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFFF0F1F9);
  
  // Dark Theme Colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0C0);
  static const Color darkTextTertiary = Color(0xFF808090);
  
  // Text Colors (Light)
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B6B80);
  static const Color textTertiary = Color(0xFFA0A0B0);
  static const Color textWhite = Color(0xFFFFFFFF);
  
  // Border Colors
  static const Color border = Color(0xFFE8E8F0);
  static const Color borderDark = Color(0xFF3A3A5A);
  
  // Glassmorphism
  static Color glassWhite = Colors.white.withOpacity(0.1);
  static Color glassDark = Colors.black.withOpacity(0.2);
  static Color glassBorder = Colors.white.withOpacity(0.2);
  
  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF00C853),
    Color(0xFF64DD17),
    Color(0xFF00BFA5),
    Color(0xFF009624),
    Color(0xFF00E676),
    Color(0xFF69F0AE),
    Color(0xFF1DE9B6),
    Color(0xFF00B8D4),
  ];
}
