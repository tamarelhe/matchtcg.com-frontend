import 'package:flutter/material.dart';
import '../../widgets/common/matchtcg_app_bar.dart';
import '../../widgets/common/primary_button.dart';
import '../../widgets/common/secondary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/extensions/localization_extension.dart';

/// Groups screen for managing player groups and communities
class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MatchTCGAppBar(
        title: context.l10n.groupsTab,
        showBackButton: false,
        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // TODO: Implement search
                  },
                  tooltip: context.l10n.search,
                ),
          ),
        ],
      ),
      body: const _GroupsContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create group
        },
        tooltip: 'Create Group',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupsContent extends StatelessWidget {
  const _GroupsContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab-like section headers
        Container(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Row(
            children: [
              _buildSectionTab('My Groups', true),
              const SizedBox(width: AppSpacing.medium),
              _buildSectionTab('Discover', false),
            ],
          ),
        ),

        // Groups list
        Expanded(child: _buildGroupsList()),
      ],
    );
  }

  Widget _buildSectionTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.small,
      ),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary.withValues(alpha: 0.1) : null,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
        border:
            isActive
                ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
                : null,
      ),
      child: Text(
        label,
        style: AppTextStyles.labelLarge.copyWith(
          color: isActive ? AppColors.primary : AppColors.onSurfaceVariant,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildGroupsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.medium),
      itemCount: 4, // Placeholder count
      itemBuilder: (context, index) {
        return _buildGroupCard(index);
      },
    );
  }

  Widget _buildGroupCard(int index) {
    final bool isOwner = index == 0;
    final bool isMember = index <= 2;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.medium),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    child: Text(
                      'G${index + 1}',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'MTG Commander Group ${index + 1}',
                              style: AppTextStyles.headlineMedium,
                            ),
                            if (isOwner) ...[
                              const SizedBox(width: AppSpacing.small),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.small,
                                  vertical: AppSpacing.micro,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusSmall,
                                  ),
                                ),
                                child: Text(
                                  'Owner',
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: AppSpacing.micro),
                        Row(
                          children: [
                            const Icon(
                              Icons.people_outline,
                              size: 16,
                              color: AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: AppSpacing.micro),
                            Text(
                              '${15 + index * 5} members',
                              style: AppTextStyles.bodyMedium,
                            ),
                            const SizedBox(width: AppSpacing.medium),
                            const Icon(
                              Icons.schedule,
                              size: 16,
                              color: AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: AppSpacing.micro),
                            const Text(
                              'Active',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.medium),
              const Text(
                'Weekly Commander games and tournaments. All skill levels welcome!',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.medium),
              Row(
                children: [
                  if (isMember) ...[
                    Expanded(
                      child: PrimaryButton(
                        text: 'View Group',
                        onPressed: () {
                          // TODO: Navigate to group details
                        },
                        height: 36,
                      ),
                    ),
                    if (isOwner) ...[
                      const SizedBox(width: AppSpacing.small),
                      SecondaryButton(
                        text: 'Manage',
                        onPressed: () {
                          // TODO: Navigate to group management
                        },
                        height: 36,
                        width: 80,
                      ),
                    ],
                  ] else ...[
                    Expanded(
                      child: SecondaryButton(
                        text: 'Join Group',
                        onPressed: () {
                          // TODO: Implement join group
                        },
                        height: 36,
                      ),
                    ),
                  ],
                  const SizedBox(width: AppSpacing.small),
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () {
                      // TODO: Implement share
                    },
                    tooltip: 'Share Group',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
