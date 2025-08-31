import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../widgets/common/matchtcg_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/providers/user_providers.dart';
import '../../../core/providers/auth_providers.dart';
import 'language_settings_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MatchTCGAppBar(
        title: context.l10n.settings,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preferences Section
            _buildSectionHeader(context.l10n.preferences),
            const SizedBox(height: AppSpacing.medium),

            _buildMenuItem(
              context: context,
              icon: Icons.language_outlined,
              title: context.l10n.languageAndRegion,
              subtitle: 'Change app language and timezone',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LanguageSettingsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSpacing.large),

            // Privacy & Data Section
            _buildSectionHeader(context.l10n.privacyAndData),
            const SizedBox(height: AppSpacing.medium),

            _buildMenuItem(
              context: context,
              icon: Icons.download_outlined,
              title: context.l10n.exportData,
              subtitle: context.l10n.exportDataDescription,
              onTap: () => _exportUserData(context, ref),
              isLoading: userState.isExporting,
            ),

            const SizedBox(height: AppSpacing.small),

            _buildMenuItem(
              context: context,
              icon: Icons.delete_forever_outlined,
              title: context.l10n.deleteAccount,
              subtitle: context.l10n.deleteAccountDescription,
              onTap: () => _showDeleteAccountDialog(context, ref),
              isDestructive: true,
              isLoading: userState.isDeleting,
            ),
          ],
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

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
    bool isLoading = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppSpacing.small),
          decoration: BoxDecoration(
            color:
                isDestructive
                    ? AppColors.error.withValues(alpha: 0.1)
                    : AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
          ),
          child:
              isLoading
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDestructive ? AppColors.error : AppColors.primary,
                      ),
                    ),
                  )
                  : Icon(
                    icon,
                    color: isDestructive ? AppColors.error : AppColors.primary,
                    size: 20,
                  ),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            color: isDestructive ? AppColors.error : AppColors.onSurface,
          ),
        ),
        subtitle: Text(subtitle, style: AppTextStyles.bodyMedium),
        trailing:
            isLoading
                ? null
                : Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
        onTap: isLoading ? null : onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        tileColor: AppColors.surface,
      ),
    );
  }

  Future<void> _exportUserData(BuildContext context, WidgetRef ref) async {
    // Capture localized strings before async operations
    final dataExportedMessage = context.l10n.dataExported;

    try {
      final data =
          await ref.read(userNotifierProvider.notifier).exportUserData();

      if (data != null) {
        // Convert data to JSON string
        final jsonString = const JsonEncoder.withIndent('  ').convert(data);

        // Save to temporary file
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/matchtcg_user_data.json');
        await file.writeAsString(jsonString);

        // Share the file
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'MatchTCG User Data Export',
          subject: 'My MatchTCG Data',
        );

        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                dataExportedMessage,
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
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to export data: ${e.toString()}',
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

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    // Capture localized strings before async operations
    final deleteAccountTitle = context.l10n.deleteAccount;
    final deleteAccountConfirmation = context.l10n.deleteAccountConfirmation;
    final cancelText = context.l10n.cancel;
    final accountDeletedMessage = context.l10n.accountDeleted;

    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            backgroundColor: AppColors.surface,
            title: Text(
              deleteAccountTitle,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.error,
              ),
            ),
            content: Text(
              deleteAccountConfirmation,
              style: AppTextStyles.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(
                  cancelText,
                  style: TextStyle(color: AppColors.onSurfaceVariant),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(dialogContext).pop();

                  final success =
                      await ref
                          .read(userNotifierProvider.notifier)
                          .deleteAccount();

                  if (!context.mounted) return;

                  if (success) {
                    // Also logout from auth
                    await ref.read(authNotifierProvider.notifier).logout();

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            accountDeletedMessage,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.onPrimary,
                            ),
                          ),
                          backgroundColor: AppColors.primary,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  } else {
                    final userState = ref.read(userNotifierProvider);
                    if (userState.error != null && context.mounted) {
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
                },
                child: Text(
                  deleteAccountTitle,
                  style: TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
    );
  }
}
