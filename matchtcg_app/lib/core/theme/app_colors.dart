import 'package:flutter/material.dart';

/// MatchTCG Dark Neon Color Palette
class AppColors {
  AppColors._();

  // Background Colors
  static const Color background = Color(0xFF0F172A); // Preto carvão
  static const Color surface = Color(0xFF111827);
  static const Color surfaceVariant = Color(0xFF0B1220);

  // Primary Colors
  static const Color primary = Color(0xFF22C55E); // Verde neon
  static const Color primaryContainer = Color(0xFF16A34A);
  static const Color onPrimary = Color(0xFF000000);

  // Secondary Colors
  static const Color secondary = Color(0xFF9333EA); // Roxo neon
  static const Color secondaryContainer = Color(0xFF7C3AED);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Text Colors
  static const Color onSurface = Color(0xFFE5E7EB); // Cinza claro
  static const Color onSurfaceVariant = Color(0xFF9CA3AF);

  // Outline Colors
  static const Color outline = Color(0xFF1F2937);
  static const Color outlineVariant = Color(0xFF374151);

  // State Colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color onError = Color(0xFFFFFFFF);

  // Utility Colors
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Gradient Colors
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surface, surfaceVariant],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryContainer],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, secondaryContainer],
  );
}