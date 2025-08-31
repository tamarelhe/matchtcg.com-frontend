/// Game interest entity representing a trading card game
class GameInterest {
  final String type;
  final String id;
  final String name;
  final String logoPath;

  const GameInterest({
    required this.type,
    required this.id,
    required this.name,
    required this.logoPath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameInterest &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'GameInterest(id: $id, name: $name, logoPath: $logoPath)';
}
