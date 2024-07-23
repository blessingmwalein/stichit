import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final double? size;
  final Function? onPressed;
  const CustomIconButton(
      {super.key, required this.icon, this.onPressed, this.size = 25});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => onPressed!(),
      radius: 50,
      child: Container(
        padding: const EdgeInsets.all(10),
        //circle
        decoration: BoxDecoration(
          color: primaryBackGroundBlack,
          borderRadius: BorderRadius.circular(50),
          // border: Border.all(color: primaryWhite, width: 1),
        ),
        child: customSvgIcon(
            iconColor: primaryWhite,
            path: icon,
            width: size ?? 25,
            height: size ?? 25),
      ),
    );
  }
}
