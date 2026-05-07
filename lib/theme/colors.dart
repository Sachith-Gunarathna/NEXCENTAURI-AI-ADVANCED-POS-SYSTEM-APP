import 'package:flutter/material.dart';

class AppColors {
  // Brand Primary Color
  static const Color primaryPurple = Color(0xFF480177); // Your specific purple
  
  // Light Mode Palette
  static const Color background = Color(0xFFFFFFFF);    // Pure White
  static const Color surface = Color(0xFFF9FAFB);       // Light Grey Surface
  static const Color textDark = Color(0xFF000000);      // Pure Black
  static const Color textGrey = Color(0xFF6B7280);
  
  // Dark Mode Palette
  static const Color darkBackground = Color(0xFF000000); // Pure Black
  static const Color darkSurface = Color(0xFF121212);    // Deep Grey Surface
  static const Color darkText = Color(0xFFFFFFFF);       // Pure White
  static const Color darkTextGrey = Color(0xFF94A3B8);
  
  // Universal Colors
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentOrange = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color successGreen = Color(0xFF10B981);
  
  // Gradient Colors
  static const List<Color> purpleGradient = [Color(0xFF6D28D9), Color(0xFF480177)];
  static const List<Color> darkGradient = [Color(0xFF1F2937), Color(0xFF000000)];
}
