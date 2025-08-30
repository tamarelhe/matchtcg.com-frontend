import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:matchtcg_app/l10n/generated/app_localizations.dart';
import 'package:matchtcg_app/presentation/providers/locale_provider.dart';
import 'package:matchtcg_app/core/extensions/localization_extension.dart';

void main() {
  group('Internationalization Tests', () {
    testWidgets('should display English text by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: SupportedLocales.all,
            home: const TestWidget(),
          ),
        ),
      );

      // Verify English text is displayed
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Events'), findsOneWidget);
      expect(find.text('Groups'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('should display Portuguese text when locale is pt', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            locale: const Locale('pt', 'PT'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: SupportedLocales.all,
            home: const TestWidget(),
          ),
        ),
      );

      // Verify Portuguese text is displayed
      expect(find.text('Início'), findsOneWidget);
      expect(find.text('Eventos'), findsOneWidget);
      expect(find.text('Grupos'), findsOneWidget);
      expect(find.text('Perfil'), findsOneWidget);
    });

    testWidgets('should change language when locale provider is updated', (
      WidgetTester tester,
    ) async {
      final container = ProviderContainer();

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: Consumer(
            builder: (context, ref, child) {
              final locale = ref.watch(localeProvider);
              return MaterialApp(
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: SupportedLocales.all,
                home: const TestWidget(),
              );
            },
          ),
        ),
      );

      // Initially should show English (default)
      expect(find.text('Home'), findsOneWidget);

      // Change to Portuguese
      container
          .read(localeProvider.notifier)
          .setLocale(SupportedLocales.portuguese);
      await tester.pumpAndSettle();

      // Should now show Portuguese
      expect(find.text('Início'), findsOneWidget);
    });

    test('SupportedLocales should correctly identify supported locales', () {
      expect(SupportedLocales.isSupported(const Locale('en')), isTrue);
      expect(SupportedLocales.isSupported(const Locale('pt')), isTrue);
      expect(SupportedLocales.isSupported(const Locale('pt', 'PT')), isTrue);
      expect(SupportedLocales.isSupported(const Locale('fr')), isFalse);
      expect(SupportedLocales.isSupported(const Locale('es')), isFalse);
    });

    test(
      'SupportedLocales should return correct locale from language code',
      () {
        expect(
          SupportedLocales.fromLanguageCode('en'),
          equals(SupportedLocales.english),
        );
        expect(
          SupportedLocales.fromLanguageCode('pt'),
          equals(SupportedLocales.portuguese),
        );
        expect(
          SupportedLocales.fromLanguageCode('fr'),
          equals(SupportedLocales.english),
        ); // fallback
      },
    );
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(context.l10n.homeTab),
          Text(context.l10n.eventsTab),
          Text(context.l10n.groupsTab),
          Text(context.l10n.profileTab),
        ],
      ),
    );
  }
}
