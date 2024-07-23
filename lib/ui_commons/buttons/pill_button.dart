import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class PillButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final String icon;
  const PillButton(
      {super.key, required this.label, this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40),
      child: Container(
          decoration: BoxDecoration(
            // color: primaryBackGroundBlack,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: primaryWhite.withOpacity(0.8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: primaryWhite.withOpacity(0.5)),
                ),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: primaryBackGroundBlack,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: customSvgIcon(
                      path: icon,
                      width: 17,
                      height: 17,
                      iconColor: primaryWhite.withOpacity(0.8)),
                )
              ],
            ),
          )),
    );
  }
}
