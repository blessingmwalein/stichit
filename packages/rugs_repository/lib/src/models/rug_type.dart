class RugType {
  static const String cutPile = 'Cut Pile';
  static const String loopPile = 'Loop Pile';
  static const String cutAndLoopPile = 'Cut and Loop Pile';
  static const String shag = 'Shag';
  static const String frieze = 'Frieze';
  static const String sculptedOrCarved = 'Sculpted or Carved';
  static const String texturedLoop = 'Textured Loop';
  static const String flatweave = 'Flatweave';
  static const String chenille = 'Chenille';
  static const String highLowPile = 'High-Low Pile';

  static const List<String> values = [
    cutPile,
    loopPile,
    cutAndLoopPile,
    shag,
    frieze,
    sculptedOrCarved,
    texturedLoop,
    flatweave,
    chenille,
    highLowPile,
  ];

  static String fromString(String name) {
    return values.firstWhere(
      (type) => type == name,
      orElse: () => throw ArgumentError('Unknown RugType: $name'),
    );
  }
}
