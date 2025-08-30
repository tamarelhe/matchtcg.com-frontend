import 'package:flutter/material.dart';
import '../../widgets/common/matchtcg_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/extensions/localization_extension.dart';

/// Home screen with map view for event discovery
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MatchTCGAppBar(
        title: null,
        showBackButton: false,
        leading: const MatchTCGLogo(),
        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: null, // TODO: Navigate to profile
                  tooltip: context.l10n.profileTab,
                ),
          ),
        ],
      ),
      body: const _HomeContent(),
      floatingActionButton: Builder(
        builder:
            (context) => FloatingActionButton(
              onPressed: () {
                // TODO: Navigate to create event
              },
              tooltip: context.l10n.createEvent,
              child: const Icon(Icons.add),
            ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Map container placeholder
        Expanded(
          child: Container(
            width: double.infinity,
            color: AppColors.surface,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 64, color: AppColors.primary),
                  SizedBox(height: AppSpacing.medium),
                  Text('Map View', style: AppTextStyles.headlineMedium),
                  SizedBox(height: AppSpacing.small),
                  Text(
                    'Interactive map with event pins will be implemented here',
                    style: AppTextStyles.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Filter chips container
        Container(
          padding: const EdgeInsets.all(AppSpacing.medium),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.outline, width: 0.5),
            ),
          ),
          child: Builder(
            builder:
                (context) => Row(
                  children: [
                    _buildFilterChip(context.l10n.all, true),
                    const SizedBox(width: AppSpacing.small),
                    _buildFilterChip('MTG', false),
                    const SizedBox(width: AppSpacing.small),
                    _buildFilterChip('Lorcana', false),
                    const SizedBox(width: AppSpacing.small),
                    _buildFilterChip('Pokémon', false),
                  ],
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // TODO: Implement filter logic
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      checkmarkColor: AppColors.primary,
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.outline,
      ),
    );
  }
}
