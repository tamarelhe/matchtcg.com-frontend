import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

/// Extension to easily access localizations from BuildContext
extension LocalizationExtension on BuildContext {
  /// Get the current AppLocalizations instance
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Get the current locale
  Locale get locale => Localizations.localeOf(this);

  /// Check if current locale is Portuguese
  bool get isPortuguese => locale.languageCode == 'pt';

  /// Check if current locale is English
  bool get isEnglish => locale.languageCode == 'en';
}
