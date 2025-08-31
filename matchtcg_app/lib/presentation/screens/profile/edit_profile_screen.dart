import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/common/matchtcg_app_bar.dart';
import '../../widgets/common/matchtcg_text_field.dart';
import '../../widgets/common/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/providers/user_providers.dart';
import '../../providers/locale_provider.dart';
import '../../widgets/profile/game_selection_widget.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();

  String? _selectedLocale;
  String? _selectedTimezone;
  List<String> _selectedGameIds = [];

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final userState = ref.read(userNotifierProvider);
    final currentLocale = ref.read(localeProvider);

    if (userState.user != null) {
      _displayNameController.text = userState.user!.displayName ?? '';
      _cityController.text = userState.user!.city ?? '';
      _countryController.text = userState.user!.country ?? '';
      _selectedLocale = userState.user!.locale;
      _selectedGameIds = List.from(userState.user!.interestedGames ?? []);
    }

    // Set current locale if not set in user profile
    _selectedLocale ??= currentLocale.languageCode;

    // Default timezone (in a real app, you'd get this from the user or device)
    _selectedTimezone ??= 'Europe/Lisbon';
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MatchTCGAppBar(
        title: context.l10n.editProfile,
        showBackButton: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Information Section
              _buildSectionHeader(context.l10n.personalInformation),
              const SizedBox(height: AppSpacing.medium),

              MatchTCGTextField(
                controller: _displayNameController,
                label: context.l10n.displayNameOptional,
                hint: 'Enter your display name',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: AppSpacing.medium),

              MatchTCGTextField(
                controller: _cityController,
                label: context.l10n.city,
                hint: 'Enter your city',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: AppSpacing.medium),

              MatchTCGTextField(
                controller: _countryController,
                label: context.l10n.country,
                hint: 'Enter your country',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: AppSpacing.large),

              // Preferences Section
              _buildSectionHeader(context.l10n.preferences),
              const SizedBox(height: AppSpacing.medium),

              _buildLanguageSelector(),
              const SizedBox(height: AppSpacing.medium),

              _buildTimezoneSelector(),
              const SizedBox(height: AppSpacing.large),

              // Game Interests Section
              _buildSectionHeader('Game Interests'),
              const SizedBox(height: AppSpacing.medium),

              GameSelectionWidget(
                selectedGameIds: _selectedGameIds,
                onSelectionChanged: (selectedIds) {
                  setState(() {
                    _selectedGameIds = selectedIds;
                  });
                },
                title: 'Select games you\'re interested in',
              ),
              const SizedBox(height: AppSpacing.xxLarge),

              // Update Button
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: context.l10n.updateProfile,
                  onPressed: userState.isUpdating ? null : _updateProfile,
                  isLoading: userState.isUpdating,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.headlineMedium.copyWith(color: AppColors.primary),
    );
  }

  Widget _buildLanguageSelector() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.outline, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.language,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.small),

          _buildLanguageOption('en', context.l10n.english, 'English'),
          const SizedBox(height: AppSpacing.small),
          _buildLanguageOption(
            'pt',
            context.l10n.portuguese,
            'Português (Portugal)',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String locale, String title, String subtitle) {
    final isSelected = _selectedLocale == locale;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLocale = locale;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.small),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color:
                  isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color:
                          isSelected ? AppColors.primary : AppColors.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimezoneSelector() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.outline, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.timezone,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.small),

          Row(
            children: [
              Icon(Icons.access_time, color: AppColors.primary, size: 20),
              const SizedBox(width: AppSpacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.currentTimezone,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      _selectedTimezone ?? 'Europe/Lisbon',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await ref
        .read(userNotifierProvider.notifier)
        .updateProfile(
          displayName:
              _displayNameController.text.trim().isEmpty
                  ? null
                  : _displayNameController.text.trim(),
          locale: _selectedLocale,
          timezone: _selectedTimezone,
          city:
              _cityController.text.trim().isEmpty
                  ? null
                  : _cityController.text.trim(),
          country:
              _countryController.text.trim().isEmpty
                  ? null
                  : _countryController.text.trim(),
          interestedGames: _selectedGameIds,
        );

    if (!mounted) return;

    if (success) {
      // Update app locale if changed
      if (_selectedLocale != null) {
        final newLocale =
            _selectedLocale == 'en'
                ? SupportedLocales.english
                : SupportedLocales.portuguese;
        await ref.read(localeProvider.notifier).setLocale(newLocale);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.l10n.profileUpdated,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onPrimary,
              ),
            ),
            backgroundColor: AppColors.primary,
            duration: const Duration(seconds: 2),
          ),
        );

        Navigator.of(context).pop();
      }
    } else {
      final userState = ref.read(userNotifierProvider);
      if (userState.error != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              userState.error!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onError,
              ),
            ),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
