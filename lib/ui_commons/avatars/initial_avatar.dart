import 'package:flutter/material.dart';
import 'dart:math';

import 'package:stichit/app/const/colors.dart';

class InitialsAvatar extends StatelessWidget {
  final String text;
  final double size;
  final double? width;
  final double? height;

  const InitialsAvatar({super.key, 
    required this.text,
    this.size = 40.0,
    this.width,
    this.height,
  });

  // Method to generate a random color
  Color _getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extract first two letters and convert to uppercase
    String initials = text.isNotEmpty ? text.substring(0, min(2, text.length)).toUpperCase() : '';

    return Container(
      width: width ?? size,
      height: height ?? size,
      decoration: BoxDecoration(
        color: _getRandomColor(),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: CustomColors.white,
          fontSize: (width ?? size) / 2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
