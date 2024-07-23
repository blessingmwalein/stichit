import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';

class LogoCard extends StatelessWidget {
  final Color? backgroundColor;
  final double? width;
  final double? height;
  const LogoCard({super.key, this.backgroundColor, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 260,
        height: height,
        width: width,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: backgroundColor ?? CustomColors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Image.asset(
          'assets/images/STICHIT-01.png',
          height: height,
          width: width,
        ));
  }
}
