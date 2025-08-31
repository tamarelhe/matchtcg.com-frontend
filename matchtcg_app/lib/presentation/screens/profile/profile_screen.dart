import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/common/matchtcg_app_bar.dart';
import '../../widgets/common/primary_button.dart';
import '../../widgets/common/secondary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/providers/auth_providers.dart';
import '../../../core/providers/user_providers.dart';
import '../../../core/constants/countries.dart';
import '../../widgets/profile/game_interests_section.dart';
import 'edit_profile_screen.dart';
import '../settings/settings_screen.dart';
import '../settings/language_settings_screen.dart';

/// Profile screen for user account management and settings
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final userState = ref.watch(userNotifierProvider);

    // Load user profile if not loaded and authenticated
    if (authState.isAuthenticated &&
        userState.user == null &&
        !userState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(userNotifierProvider.notifier).loadCurrentUser();
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MatchTCGAppBar(
        title: context.l10n.profileTab,
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            tooltip: context.l10n.settings,
          ),
        ],
      ),
      body: _ProfileContent(
        user: userState.user ?? authState.user,
        userState: userState,
      ),
    );
  }
}

class _ProfileContent extends ConsumerWidget {
  final dynamic user;
  final dynamic userState;

  const _ProfileContent({this.user, this.userState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        children: [
          // Profile header
          _buildProfileHeader(context),
          const SizedBox(height: AppSpacing.large),

          // Quick stats
          _buildQuickStats(),
          const SizedBox(height: AppSpacing.large),

          // Game interests
          GameInterestsSection(
            interestedGameIds:
                userState.user?.interestedGames ?? user?.interestedGames,
            title: 'Interested Games',
          ),
          const SizedBox(height: AppSpacing.large),

          // Action buttons
          _buildActionButtons(),
          const SizedBox(height: AppSpacing.large),

          // Menu items
          _buildMenuItems(context, ref),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.outline, width: 0.5),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            child: Text(
              _getInitials(),
              style: AppTextStyles.displayMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.medium),
          Text(user?.displayName ?? 'User', style: AppTextStyles.headlineLarge),
          const SizedBox(height: AppSpacing.micro),
          Text(user?.email ?? '', style: AppTextStyles.bodyMedium),
          const SizedBox(height: AppSpacing.small),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.medium,
              vertical: AppSpacing.small,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
            child: _buildLocationWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Events Attended', '12')),
        const SizedBox(width: AppSpacing.medium),
        Expanded(child: _buildStatCard('Groups Joined', '3')),
        const SizedBox(width: AppSpacing.medium),
        Expanded(child: _buildStatCard('Events Created', '2')),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.outline, width: 0.5),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.micro),
          Text(
            label,
            style: AppTextStyles.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Builder(
            builder:
                (context) => PrimaryButton(
                  text: context.l10n.edit,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                  icon: Icons.edit_outlined,
                ),
          ),
        ),
        const SizedBox(width: AppSpacing.medium),
        Expanded(
          child: Builder(
            builder:
                (context) => SecondaryButton(
                  text: context.l10n.share,
                  onPressed: () {
                    // TODO: Implement share profile
                  },
                  icon: Icons.share_outlined,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.event_outlined,
          title: 'My Events',
          subtitle: 'View and manage your events',
          onTap: () {
            // TODO: Navigate to my events
          },
        ),
        _buildMenuItem(
          icon: Icons.group_outlined,
          title: 'My Groups',
          subtitle: 'Manage your group memberships',
          onTap: () {
            // TODO: Navigate to my groups
          },
        ),
        _buildMenuItem(
          icon: Icons.favorite_outline,
          title: 'Favorite Venues',
          subtitle: 'Your saved gaming locations',
          onTap: () {
            // TODO: Navigate to favorite venues
          },
        ),
        _buildMenuItem(
          icon: Icons.calendar_month_outlined,
          title: 'Calendar Integration',
          subtitle: 'Sync with your calendar app',
          onTap: () {
            // TODO: Navigate to calendar settings
          },
        ),
        _buildMenuItem(
          icon: Icons.language_outlined,
          title: 'Language & Region',
          subtitle: 'Change app language and timezone',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LanguageSettingsScreen(),
              ),
            );
          },
        ),
        _buildMenuItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy & Data',
          subtitle: 'Manage your privacy settings',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        _buildMenuItem(
          icon: Icons.help_outline,
          title: 'Help & Support',
          subtitle: 'Get help and contact support',
          onTap: () {
            // TODO: Navigate to help
          },
        ),
        _buildMenuItem(
          icon: Icons.logout,
          title: context.l10n.logout,
          subtitle: 'Sign out of your account',
          onTap: () => _showLogoutDialog(ref),
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
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
          child: Icon(
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
        trailing: Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        tileColor: AppColors.surface,
      ),
    );
  }

  Widget _buildLocationWidget(BuildContext context) {
    final locationText = _getLocationText(context);

    if (locationText.isEmpty) {
      return const SizedBox.shrink(); // Don't show location if no data
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: AppSpacing.micro),
        Text(locationText, style: AppTextStyles.labelMedium),
      ],
    );
  }

  String _getLocationText(BuildContext context) {
    final city = user?.city;
    final countryCode = user?.country;

    // Convert country code to localized country name
    final countryName = Countries.getCountryName(context, countryCode);

    if (city != null && city.isNotEmpty && countryName.isNotEmpty) {
      return '$city, $countryName';
    } else if (city != null && city.isNotEmpty) {
      return city;
    } else if (countryName.isNotEmpty) {
      return countryName;
    }

    return ''; // No location data available
  }

  String _getInitials() {
    if (user?.displayName != null && user!.displayName!.isNotEmpty) {
      final names = user!.displayName!.split(' ');
      if (names.length >= 2) {
        return '${names[0][0]}${names[1][0]}'.toUpperCase();
      }
      return user!.displayName![0].toUpperCase();
    }

    if (user?.email != null && user!.email!.isNotEmpty) {
      return user!.email![0].toUpperCase();
    }

    return 'U';
  }

  void _showLogoutDialog(WidgetRef ref) {
    final context = ref.context;
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            backgroundColor: AppColors.surface,
            title: Text('Sign Out', style: AppTextStyles.headlineMedium),
            content: Text(
              'Are you sure you want to sign out?',
              style: AppTextStyles.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(
                  context.l10n.cancel,
                  style: TextStyle(color: AppColors.onSurfaceVariant),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  ref.read(authNotifierProvider.notifier).logout();
                },
                child: Text(
                  context.l10n.logout,
                  style: TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
    );
  }
}
