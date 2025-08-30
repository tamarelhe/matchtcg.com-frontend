import 'package:flutter/material.dart';
import '../../widgets/common/matchtcg_app_bar.dart';
import '../../widgets/common/primary_button.dart';
import '../../widgets/common/secondary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// Profile screen for user account management and settings
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MatchTCGAppBar(
        title: 'Profile',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Navigate to settings
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: const _ProfileContent(),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        children: [
          // Profile header
          _buildProfileHeader(),
          const SizedBox(height: AppSpacing.large),
          
          // Quick stats
          _buildQuickStats(),
          const SizedBox(height: AppSpacing.large),
          
          // Action buttons
          _buildActionButtons(),
          const SizedBox(height: AppSpacing.large),
          
          // Menu items
          _buildMenuItems(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(
          color: AppColors.outline,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            child: Text(
              'JD',
              style: AppTextStyles.displayMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.medium),
          const Text(
            'John Doe',
            style: AppTextStyles.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.micro),
          const Text(
            'john.doe@example.com',
            style: AppTextStyles.bodyMedium,
          ),
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
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                SizedBox(width: AppSpacing.micro),
                Text(
                  'Lisbon, Portugal',
                  style: AppTextStyles.labelMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('Events Attended', '12'),
        ),
        const SizedBox(width: AppSpacing.medium),
        Expanded(
          child: _buildStatCard('Groups Joined', '3'),
        ),
        const SizedBox(width: AppSpacing.medium),
        Expanded(
          child: _buildStatCard('Events Created', '2'),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(
          color: AppColors.outline,
          width: 0.5,
        ),
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
          child: PrimaryButton(
            text: 'Edit Profile',
            onPressed: () {
              // TODO: Navigate to edit profile
            },
            icon: Icons.edit_outlined,
          ),
        ),
        const SizedBox(width: AppSpacing.medium),
        Expanded(
          child: SecondaryButton(
            text: 'Share Profile',
            onPressed: () {
              // TODO: Implement share profile
            },
            icon: Icons.share_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
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
            // TODO: Navigate to language settings
          },
        ),
        _buildMenuItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy & Data',
          subtitle: 'Manage your privacy settings',
          onTap: () {
            // TODO: Navigate to privacy settings
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
          title: 'Sign Out',
          subtitle: 'Sign out of your account',
          onTap: () {
            // TODO: Implement sign out
          },
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
            color: isDestructive
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
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodyMedium,
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: AppColors.onSurfaceVariant,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        tileColor: AppColors.surface,
      ),
    );
  }
}