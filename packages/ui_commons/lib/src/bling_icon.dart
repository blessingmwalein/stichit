// ignore_for_file: public_member_api_docs, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlingIcon extends StatelessWidget {
  const BlingIcon({
    required this.path,
    required this.width,
    required this.height,
    super.key,
    this.iconColor,
  });
  final String path;
  final double width;
  final double height;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      color: iconColor,
    );
  }
}
