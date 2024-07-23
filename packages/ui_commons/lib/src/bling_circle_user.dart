// ignore_for_file: public_member_api_docs, use_super_parameters

import 'package:flutter/material.dart';
import 'package:ui_commons/src/bling_icon.dart';
import 'package:ui_commons/src/constants/theme.dart';
import 'package:ui_commons/ui_commons.dart'; // Assuming your UI commons package is imported as ui_commons

class BlingUserCircleAvatar extends StatelessWidget {
  const BlingUserCircleAvatar({
    required this.imagePath,
    required this.isOnline,
    Key? key,
    this.onTap,
  }) : super(key: key);
  final String imagePath;
  final bool isOnline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    //user profile image; circle radius
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isOnline ? Colors.orange: Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
