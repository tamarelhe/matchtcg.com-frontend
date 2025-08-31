import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

/// Country constants and utilities
class Countries {
  /// List of supported ISO alpha-2 country codes
  static const List<String> supportedCountryCodes = [
    'PT',
    'ES',
    'FR',
    'DE',
    'IT',
    'GB',
    'US',
    'BR',
    'NL',
    'BE',
    'CH',
    'AT',
    'IE',
    'LU',
    'DK',
    'SE',
    'NO',
    'FI',
    'PL',
    'CZ',
  ];

  /// Get localized country name from ISO alpha-2 code
  /// Returns the localized country name if found, otherwise returns the code itself
  static String getCountryName(BuildContext context, String? countryCode) {
    if (countryCode == null || countryCode.isEmpty) {
      return '';
    }

    final l10n = AppLocalizations.of(context);

    switch (countryCode) {
      case 'PT':
        return l10n.countryPT;
      case 'ES':
        return l10n.countryES;
      case 'FR':
        return l10n.countryFR;
      case 'DE':
        return l10n.countryDE;
      case 'IT':
        return l10n.countryIT;
      case 'GB':
        return l10n.countryGB;
      case 'US':
        return l10n.countryUS;
      case 'BR':
        return l10n.countryBR;
      case 'NL':
        return l10n.countryNL;
      case 'BE':
        return l10n.countryBE;
      case 'CH':
        return l10n.countryCH;
      case 'AT':
        return l10n.countryAT;
      case 'IE':
        return l10n.countryIE;
      case 'LU':
        return l10n.countryLU;
      case 'DK':
        return l10n.countryDK;
      case 'SE':
        return l10n.countrySE;
      case 'NO':
        return l10n.countryNO;
      case 'FI':
        return l10n.countryFI;
      case 'PL':
        return l10n.countryPL;
      case 'CZ':
        return l10n.countryCZ;
      default:
        return countryCode;
    }
  }

  /// Get map of country codes to localized names for dropdowns
  static Map<String, String> getCountryMap(BuildContext context) {
    final Map<String, String> countryMap = {};
    for (final code in supportedCountryCodes) {
      countryMap[code] = getCountryName(context, code);
    }
    return countryMap;
  }

  /// Get all country codes
  static List<String> get countryCodes => supportedCountryCodes;
}
