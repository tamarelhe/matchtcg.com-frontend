import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported locales for the application
class SupportedLocales {
  static const english = Locale('en');
  static const portuguese = Locale('pt', 'PT');

  static const List<Locale> all = [english, portuguese];

  /// Get locale from language code
  static Locale fromLanguageCode(String languageCode) {
    switch (languageCode) {
      case 'pt':
        return portuguese;
      case 'en':
      default:
        return english;
    }
  }

  /// Check if locale is supported
  static bool isSupported(Locale locale) {
    return all.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }
}

/// Locale state notifier for managing app language
class LocaleNotifier extends StateNotifier<Locale> {
  static const String _localeKey = 'app_locale';

  LocaleNotifier() : super(SupportedLocales.english) {
    _loadSavedLocale();
  }

  /// Load saved locale from shared preferences or detect device locale
  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguageCode = prefs.getString(_localeKey);

      if (savedLanguageCode != null) {
        // Use saved locale
        state = SupportedLocales.fromLanguageCode(savedLanguageCode);
      } else {
        // Detect device locale with fallback to English
        final deviceLocale = PlatformDispatcher.instance.locale;
        if (SupportedLocales.isSupported(deviceLocale)) {
          state = SupportedLocales.fromLanguageCode(deviceLocale.languageCode);
        } else {
          // Fallback to English if device locale is not supported
          state = SupportedLocales.english;
        }

        // Save the detected/fallback locale
        await _saveLocale(state.languageCode);
      }
    } catch (e) {
      // If there's any error, fallback to English
      state = SupportedLocales.english;
    }
  }

  /// Change the app locale
  Future<void> setLocale(Locale locale) async {
    if (SupportedLocales.isSupported(locale)) {
      state = locale;
      await _saveLocale(locale.languageCode);
    }
  }

  /// Save locale to shared preferences
  Future<void> _saveLocale(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, languageCode);
    } catch (e) {
      // Handle error silently - locale will still work for current session
    }
  }

  /// Toggle between supported languages
  Future<void> toggleLanguage() async {
    final newLocale =
        state.languageCode == 'en'
            ? SupportedLocales.portuguese
            : SupportedLocales.english;
    await setLocale(newLocale);
  }
}

/// Provider for locale state management
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

/// Provider for getting current language code
final currentLanguageProvider = Provider<String>((ref) {
  final locale = ref.watch(localeProvider);
  return locale.languageCode;
});

/// Provider for checking if current language is Portuguese
final isPortugueseProvider = Provider<bool>((ref) {
  final locale = ref.watch(localeProvider);
  return locale.languageCode == 'pt';
});
