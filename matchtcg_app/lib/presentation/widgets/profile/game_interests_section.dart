import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/games.dart';
import '../../../domain/entities/game_interest.dart';

/// Widget to display user's game interests in a horizontal scrollable list
class GameInterestsSection extends StatelessWidget {
  final List<String>? interestedGameIds;
  final String title;

  const GameInterestsSection({
    super.key,
    this.interestedGameIds,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (interestedGameIds == null || interestedGameIds!.isEmpty) {
      return const SizedBox.shrink();
    }

    final interestedGames = Games.getGamesByIds(interestedGameIds!);

    if (interestedGames.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          child: Text(title, style: AppTextStyles.headlineMedium),
        ),
        const SizedBox(height: AppSpacing.small),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            itemCount: interestedGames.length,
            itemBuilder: (context, index) {
              final game = interestedGames[index];
              return Padding(
                padding: EdgeInsets.only(
                  right:
                      index < interestedGames.length - 1 ? AppSpacing.small : 0,
                ),
                child: _GameLogoCard(game: game),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GameLogoCard extends StatelessWidget {
  final GameInterest game;

  const _GameLogoCard({required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surfaceAlpha,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.outline, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        child: Image.asset(
          game.logoPath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.surface,
              child: Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.onSurfaceVariant,
                size: 24,
              ),
            );
          },
        ),
      ),
    );
  }
}
