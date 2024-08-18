import 'package:flutter/material.dart';
import 'dart:math';

class InitialsAvatar extends StatelessWidget {
  final String text;
  final double size;
  final double? width;
  final double? height;

  const InitialsAvatar({
    super.key,
    required this.text,
    this.size = 40.0,
    this.width,
    this.height,
  });

  // Method to select a random color from a predefined list
  Color _getRandomPredefinedColor() {
    final random = Random();
    final List<Color> predefinedColors = [
      Colors.pink,
      Colors.purple,
      Colors.blue,
      Colors.orange,
      Colors.red,
      Colors.amber, // Gold-like color
    ];
    return predefinedColors[random.nextInt(predefinedColors.length)];
  }

  // Method to generate a contrasting text color
  Color _getContrastingTextColor(Color backgroundColor) {
    // Using luminance to determine the contrast
    return backgroundColor.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    // Extract initials based on whether the text has two parts or not
    String initials;
    List<String> parts = text.split(' ');

    if (parts.length >= 2) {
      // Take the first letter of the first two parts
      initials = parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
    } else {
      // Take the first two letters of the single part
      initials = text.isNotEmpty
          ? text.substring(0, min(2, text.length)).toUpperCase()
          : '';
    }

    // Get a random predefined background color
    Color backgroundColor = _getRandomPredefinedColor();
    // Get a contrasting text color
    Color textColor = _getContrastingTextColor(backgroundColor);

    return Container(
      width: width ?? size,
      height: height ?? size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: textColor,
          fontSize: (width ?? size) / 2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
