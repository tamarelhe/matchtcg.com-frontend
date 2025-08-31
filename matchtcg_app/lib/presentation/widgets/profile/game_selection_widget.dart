import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/games.dart';
import '../../../domain/entities/game_interest.dart';

/// Widget for selecting game interests with horizontal scrollable cards
class GameSelectionWidget extends StatefulWidget {
  final List<String> selectedGameIds;
  final ValueChanged<List<String>> onSelectionChanged;
  final String title;

  const GameSelectionWidget({
    super.key,
    required this.selectedGameIds,
    required this.onSelectionChanged,
    required this.title,
  });

  @override
  State<GameSelectionWidget> createState() => _GameSelectionWidgetState();
}

class _GameSelectionWidgetState extends State<GameSelectionWidget> {
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.selectedGameIds);
  }

  void _toggleGame(String gameId) {
    setState(() {
      if (_selectedIds.contains(gameId)) {
        _selectedIds.remove(gameId);
      } else {
        _selectedIds.add(gameId);
      }
    });
    widget.onSelectionChanged(_selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppTextStyles.headlineMedium),
        const SizedBox(height: AppSpacing.small),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Games.availableGames.length,
            itemBuilder: (context, index) {
              final game = Games.availableGames[index];
              final isSelected = _selectedIds.contains(game.id);

              return Padding(
                padding: EdgeInsets.only(
                  right:
                      index < Games.availableGames.length - 1
                          ? AppSpacing.small
                          : 0,
                ),
                child: _SelectableGameCard(
                  game: game,
                  isSelected: isSelected,
                  onTap: () => _toggleGame(game.id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SelectableGameCard extends StatelessWidget {
  final GameInterest game;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableGameCard({
    required this.game,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.surfaceAlpha,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outline,
            width: isSelected ? 2.0 : 0.5,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(AppSpacing.small),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                  child: Image.asset(
                    game.logoPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.surface,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.onSurfaceVariant,
                          size: 20,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.micro,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppSpacing.radiusMedium),
                    bottomRight: Radius.circular(AppSpacing.radiusMedium),
                  ),
                ),
                child: Icon(Icons.check, color: AppColors.onPrimary, size: 16),
              ),
          ],
        ),
      ),
    );
  }
}
