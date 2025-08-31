import 'package:flutter/foundation.dart';
import '../../domain/entities/game_interest.dart';

/// Available trading card games
class Games {
  /// Helper method to get correct asset path for different platforms
  static String _getAssetPath(String path) {
    // For web, remove the 'assets/' prefix as it's added automatically
    if (kIsWeb && path.startsWith('assets/')) {
      return path.substring(7); // Remove 'assets/' prefix
    }
    return path;
  }

  static final List<GameInterest> availableGames = [
    GameInterest(
      type: 'tcg',
      id: 'magic',
      name: 'Magic: The Gathering',
      logoPath: _getAssetPath('assets/images/brands_logo/magic.png'),
    ),
    GameInterest(
      type: 'tcg',
      id: 'pokemon',
      name: 'Pokémon TCG',
      logoPath: _getAssetPath('assets/images/brands_logo/pokemon.png'),
    ),
    GameInterest(
      type: 'tcg',
      id: 'yugioh',
      name: 'Yu-Gi-Oh!',
      logoPath: _getAssetPath('assets/images/brands_logo/yugioh.png'),
    ),
    GameInterest(
      type: 'tcg',
      id: 'dragonball',
      name: 'Dragon Ball Super',
      logoPath: _getAssetPath('assets/images/brands_logo/dragonball.png'),
    ),
    GameInterest(
      type: 'tcg',
      id: 'onepiece',
      name: 'One Piece Card Game',
      logoPath: _getAssetPath('assets/images/brands_logo/onepiece.webp'),
    ),
    GameInterest(
      type: 'tcg',
      id: 'lorcana',
      name: 'Disney Lorcana',
      logoPath: _getAssetPath('assets/images/brands_logo/lorcana.png'),
    ),
    GameInterest(
      type: 'tcg',
      id: 'digimon',
      name: 'Digimon Card Game',
      logoPath: _getAssetPath('assets/images/brands_logo/digimon.webp'),
    ),
    GameInterest(
      type: 'tcg',
      id: 'fleshandblood',
      name: 'Flesh and Blood',
      logoPath: _getAssetPath('assets/images/brands_logo/fleshandblood.webp'),
    ),
  ];

  /// Get game by ID
  static GameInterest? getGameById(String id) {
    try {
      return availableGames.firstWhere((game) => game.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get games by list of IDs
  static List<GameInterest> getGamesByIds(List<String> ids) {
    return ids
        .map((id) => getGameById(id))
        .where((game) => game != null)
        .cast<GameInterest>()
        .toList();
  }
}
