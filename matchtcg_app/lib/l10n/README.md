# Internationalization (i18n) Implementation

This document describes the internationalization setup for the MatchTCG Flutter app.

## Overview

The app supports two languages:
- **English (en)** - Default language with fallback support
- **Portuguese (pt-PT)** - Portuguese (Portugal) localization

## Implementation Details

### 1. Configuration Files

- **`l10n.yaml`** - Flutter localization configuration
- **`lib/l10n/app_en.arb`** - English translations (template file)
- **`lib/l10n/app_pt.arb`** - Portuguese translations

### 2. Generated Files

Flutter automatically generates the following files when running `flutter gen-l10n`:
- `lib/l10n/generated/app_localizations.dart` - Main localizations class
- `lib/l10n/generated/app_localizations_en.dart` - English localizations
- `lib/l10n/generated/app_localizations_pt.dart` - Portuguese localizations

### 3. State Management

**`LocaleProvider`** (`lib/presentation/providers/locale_provider.dart`):
- Manages app locale state using Riverpod
- Persists language preference using SharedPreferences
- Detects device locale with fallback to English
- Provides methods for runtime language switching

### 4. Helper Extensions

**`LocalizationExtension`** (`lib/core/extensions/localization_extension.dart`):
- Provides easy access to localizations via `context.l10n`
- Includes helper methods for locale checking

### 5. Main App Integration

The main app (`lib/main.dart`) is configured with:
- `ProviderScope` for Riverpod state management
- Localization delegates for Flutter, Material, and Cupertino
- Supported locales list
- Locale resolution callback with fallback strategy

## Usage Examples

### Accessing Translations
```dart
// Using the extension
Text(context.l10n.homeTab)

// Direct access
Text(AppLocalizations.of(context).homeTab)
```

### Changing Language
```dart
// Using Riverpod provider
ref.read(localeProvider.notifier).setLocale(SupportedLocales.portuguese);

// Toggle between languages
ref.read(localeProvider.notifier).toggleLanguage();
```

### Checking Current Language
```dart
// Using extension
if (context.isPortuguese) {
  // Portuguese-specific logic
}

// Using provider
final isPortuguese = ref.watch(isPortugueseProvider);
```

## Adding New Translations

1. Add the key-value pair to both `.arb` files:
   ```json
   // app_en.arb
   "newKey": "English Text",
   "@newKey": {
     "description": "Description of the text"
   }
   
   // app_pt.arb
   "newKey": "Texto em Português"
   ```

2. Run `flutter gen-l10n` to regenerate localization files

3. Use in code: `context.l10n.newKey`

## Adding New Languages

1. Create new `.arb` file (e.g., `app_fr.arb` for French)
2. Add locale to `SupportedLocales.all` list
3. Add case to `SupportedLocales.fromLanguageCode()` method
4. Update `isSupported()` method if needed

## Device Locale Detection

The app automatically detects the device locale on first launch:
- If device locale is supported → Use device locale
- If device locale is not supported → Fallback to English
- User preference is saved and takes precedence on subsequent launches

## Persistence

Language preferences are automatically saved to device storage using SharedPreferences and restored when the app restarts.

## Testing

Comprehensive tests are available in `test/internationalization_test.dart` covering:
- Default language display
- Language switching
- Locale provider functionality
- Supported locale validation