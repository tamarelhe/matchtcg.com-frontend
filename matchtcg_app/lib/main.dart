import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'core/utils/token_refresh_manager.dart';
import 'l10n/generated/app_localizations.dart';
import 'presentation/providers/locale_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style for dark theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const ProviderScope(child: MatchTCGApp()));
}

class MatchTCGApp extends ConsumerWidget {
  const MatchTCGApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final router = ref.watch(goRouterProvider);

    // Initialize token refresh manager (disable timer during tests)
    const isTest = bool.fromEnvironment('FLUTTER_TEST');
    TokenRefreshManager.initialize(ref, enableTimer: !isTest);

    return MaterialApp.router(
      title: 'MatchTCG',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,

      // Localization configuration
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SupportedLocales.all,

      // Locale resolution strategy
      localeResolutionCallback: (locale, supportedLocales) {
        // If device locale is supported, use it
        if (locale != null && SupportedLocales.isSupported(locale)) {
          return SupportedLocales.fromLanguageCode(locale.languageCode);
        }

        // Fallback to English
        return SupportedLocales.english;
      },
    );
  }
}
