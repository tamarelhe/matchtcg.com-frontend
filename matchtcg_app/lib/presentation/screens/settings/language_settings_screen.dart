import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/common/matchtcg_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../providers/locale_provider.dart';

/// Language settings screen for changing app language
class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MatchTCGAppBar(
        title: context.l10n.language,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.language, style: AppTextStyles.headlineMedium),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Select your preferred language for the app interface.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.large),

            // Language options
            _buildLanguageOption(
              context: context,
              ref: ref,
              locale: SupportedLocales.english,
              title: context.l10n.english,
              subtitle: 'English',
              isSelected: currentLocale.languageCode == 'en',
            ),
            const SizedBox(height: AppSpacing.small),
            _buildLanguageOption(
              context: context,
              ref: ref,
              locale: SupportedLocales.portuguese,
              title: context.l10n.portuguese,
              subtitle: 'Português (Portugal)',
              isSelected: currentLocale.languageCode == 'pt',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required WidgetRef ref,
    required Locale locale,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppSpacing.small),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.outline,
              width: isSelected ? 1.5 : 0.5,
            ),
          ),
          child: Icon(
            Icons.language,
            color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            color: isSelected ? AppColors.primary : AppColors.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        subtitle: Text(subtitle, style: AppTextStyles.bodyMedium),
        trailing:
            isSelected
                ? Icon(Icons.check_circle, color: AppColors.primary)
                : Icon(
                  Icons.radio_button_unchecked,
                  color: AppColors.onSurfaceVariant,
                ),
        onTap: () async {
          if (!isSelected) {
            await ref.read(localeProvider.notifier).setLocale(locale);

            // Show confirmation snackbar
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Language changed to ${locale.languageCode == 'en' ? 'English' : 'Português'}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                  backgroundColor: AppColors.primary,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        tileColor:
            isSelected
                ? AppColors.primary.withValues(alpha: 0.05)
                : AppColors.surface,
      ),
    );
  }
}
