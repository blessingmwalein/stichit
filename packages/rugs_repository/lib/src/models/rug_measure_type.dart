class RugMeasureType {
  static const String lw = 'lxw';
  static const String sqcm = 'sqcm';

  static const List<String> values = [lw, sqcm];

  static String fromString(String name) {
    return values.firstWhere((type) => type == name,
        orElse: () => throw ArgumentError('Unknown RugMeasureType: $name'));
  }
}
