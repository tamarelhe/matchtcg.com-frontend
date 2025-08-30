import 'package:flutter/material.dart';
import '../../widgets/common/matchtcg_app_bar.dart';
import '../../widgets/common/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/extensions/localization_extension.dart';

/// Events list screen for browsing and managing events
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MatchTCGAppBar(
        title: context.l10n.eventsTab,
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
      body: const _EventsContent(),
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

class _EventsContent extends StatelessWidget {
  const _EventsContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter chips
        Container(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
                      const SizedBox(width: AppSpacing.small),
                      _buildFilterChip('Other', false),
                    ],
                  ),
            ),
          ),
        ),

        // Events list
        Expanded(child: _buildEventsList()),
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

  Widget _buildEventsList() {
    // Placeholder for events list
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.medium),
      itemCount: 5, // Placeholder count
      itemBuilder: (context, index) {
        return _buildEventCard(index);
      },
    );
  }

  Widget _buildEventCard(int index) {
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.small,
                      vertical: AppSpacing.micro,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusSmall,
                      ),
                    ),
                    child: const Text('MTG', style: AppTextStyles.labelMedium),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.people_outline,
                    size: 16,
                    color: AppColors.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.micro),
                  const Text('12/20', style: AppTextStyles.labelMedium),
                ],
              ),
              const SizedBox(height: AppSpacing.small),
              Text(
                'Weekly Commander Night #${index + 1}',
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.micro),
              const Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: AppColors.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.micro),
                  Text('Today, 7:00 PM', style: AppTextStyles.bodyMedium),
                  SizedBox(width: AppSpacing.medium),
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.micro),
                  Text('Local Game Store', style: AppTextStyles.bodyMedium),
                ],
              ),
              const SizedBox(height: AppSpacing.medium),
              Row(
                children: [
                  Expanded(
                    child: Builder(
                      builder:
                          (context) => PrimaryButton(
                            text: context.l10n.going,
                            onPressed: () {
                              // TODO: Implement RSVP
                            },
                            height: 36,
                          ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.small),
                  Builder(
                    builder:
                        (context) => IconButton(
                          icon: const Icon(Icons.share_outlined),
                          onPressed: () {
                            // TODO: Implement share
                          },
                          tooltip: context.l10n.share,
                        ),
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
