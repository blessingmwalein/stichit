import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget customSvgIcon(
    {required String path,
    required double width,
    required double height,
    Color? iconColor}) {
  return SvgPicture.asset(
    path, // Replace with your icon's path
    width: width, // Set the width and height as needed
    height: height,
    // ignore: deprecated_member_use
    color: iconColor,
  );
}
