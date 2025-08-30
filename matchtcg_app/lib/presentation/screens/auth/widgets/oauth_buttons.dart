import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/providers/auth_providers.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../widgets/common/secondary_button.dart';

class OAuthButtons extends ConsumerWidget {
  final bool isLoading;

  const OAuthButtons({super.key, required this.isLoading});

  Future<void> _handleGoogleOAuth(BuildContext context, WidgetRef ref) async {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    try {
      final oauthData = await authNotifier.getGoogleOAuthUrl();
      if (oauthData != null && oauthData['auth_url'] != null) {
        final url = Uri.parse(oauthData['auth_url'] as String);

        if (await canLaunchUrl(url)) {
          await launchUrl(
            url,
            mode:
                kIsWeb
                    ? LaunchMode.platformDefault
                    : LaunchMode.externalApplication,
          );
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open Google sign-in')),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign-in failed: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _handleAppleOAuth(BuildContext context, WidgetRef ref) async {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    try {
      final oauthData = await authNotifier.getAppleOAuthUrl();
      if (oauthData != null && oauthData['auth_url'] != null) {
        final url = Uri.parse(oauthData['auth_url'] as String);

        if (await canLaunchUrl(url)) {
          await launchUrl(
            url,
            mode:
                kIsWeb
                    ? LaunchMode.platformDefault
                    : LaunchMode.externalApplication,
          );
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open Apple sign-in')),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Apple sign-in failed: ${e.toString()}')),
        );
      }
    }
  }

  bool _shouldShowAppleButton() {
    if (kIsWeb) {
      return true; // Always show on web
    }

    try {
      return Platform.isIOS || Platform.isMacOS;
    } catch (e) {
      return false; // If Platform check fails, don't show
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Google OAuth button
        SecondaryButton(
          text: context.l10n.signInWithGoogle,
          onPressed: isLoading ? null : () => _handleGoogleOAuth(context, ref),
          icon: Icons.g_mobiledata,
        ),
        const SizedBox(height: AppSpacing.medium),

        // Apple OAuth button (only show on iOS, macOS, or web)
        if (_shouldShowAppleButton()) ...[
          SecondaryButton(
            text: context.l10n.signInWithApple,
            onPressed: isLoading ? null : () => _handleAppleOAuth(context, ref),
            icon: Icons.apple,
          ),
        ],
      ],
    );
  }
}
