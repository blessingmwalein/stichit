import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class ErrorPage extends StatelessWidget {
  final String? message;
  const ErrorPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customSvgIcon(
              path: "assets/icons/exclamation-circle.svg",
              width: 30,
              height: 30,
              iconColor: primaryWhite),
          const SizedBox(height: 10),
          Text(
            message ?? 'An error occurred',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
