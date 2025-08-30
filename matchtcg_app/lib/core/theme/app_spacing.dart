/// MatchTCG Spacing System
/// Base unit: 4dp with consistent multipliers
class AppSpacing {
  AppSpacing._();

  // Base unit
  static const double base = 4.0;

  // Spacing Scale
  static const double micro = base; // 4dp
  static const double small = base * 2; // 8dp
  static const double medium = base * 4; // 16dp
  static const double large = base * 6; // 24dp
  static const double xLarge = base * 8; // 32dp
  static const double xxLarge = base * 12; // 48dp

  // Component-specific spacing
  static const double buttonPadding = medium; // 16dp
  static const double cardPadding = medium; // 16dp
  static const double screenPadding = medium; // 16dp
  static const double listItemSpacing = small; // 8dp
  static const double sectionSpacing = large; // 24dp

  // Touch targets
  static const double minTouchTarget = 44.0; // 44dp minimum
  static const double touchTargetPadding = small; // 8dp between targets

  // Border radius
  static const double radiusSmall = small; // 8dp
  static const double radiusMedium = 12.0; // 12dp
  static const double radiusLarge = medium; // 16dp
  static const double radiusXLarge = 20.0; // 20dp
  static const double radiusCircular = 50.0; // 50% for circular elements

  // Elevation levels
  static const double elevation0 = 0.0;
  static const double elevation1 = 2.0;
  static const double elevation2 = 4.0;
  static const double elevation3 = 8.0;
  static const double elevation4 = 16.0;
}