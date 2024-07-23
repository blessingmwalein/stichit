class RugShape {
  static const String rectangle = 'Rectangle';
  static const String square = 'Square';
  static const String circle = 'Circle';
  static const String oval = 'Oval';
  static const String runner = 'Runner';
  static const String custom = 'Custom';

  static const List<String> values = [
    rectangle,
    square,
    circle,
    oval,
    runner,
    custom,
  ];

  static String fromString(String name) {
    return values.firstWhere((shape) => shape == name,
        orElse: () => throw ArgumentError('Unknown RugShape: $name'));
  }
}
