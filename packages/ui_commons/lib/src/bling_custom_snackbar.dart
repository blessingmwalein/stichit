// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:ui_commons/src/constants/theme.dart';

class BlingCustomSnackbar {
  static void showSuccess(
    BuildContext context,
    String message, {
    IconData? iconData,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // Set the behavior to floating

        content: Row(
          children: [
            Icon(iconData ?? Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: backgroundColor ??
            primaryBackGroundBlack, // Adjust opacity as needed
      ),
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    IconData? iconData,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // Set the behavior to floating

        content: Row(
          children: [
            Icon(iconData ?? Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Text(message, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: backgroundColor ??
            Colors.red, // Adjust opacity as needed
      ),
    );
  }
}
