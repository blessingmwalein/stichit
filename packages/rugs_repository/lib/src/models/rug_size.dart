class RugSize {
  static const String small = 'Small';
  static const String medium = 'Medium';
  static const String large = 'Large';

  static const List<String> values = [small, medium, large];

  static String fromString(String name) {
    return values.firstWhere(
      (type) => type == name,
      orElse: () => throw ArgumentError('Unknown Rug Size: $name'),
    );
  }
}
