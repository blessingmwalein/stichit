// ignore_for_file: public_member_api_docs, always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:ui_commons/src/constants/theme.dart';

class CountCards extends StatelessWidget {
  const CountCards({
    super.key,
    required this.label,
    required this.count,
    required this.backgroundColor,
  });
  final String label;
  final int count;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150,
      // height: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.normal,
              color: primaryBlack.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: primaryBlack.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
