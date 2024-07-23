import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class CustomButton extends StatelessWidget {
  final String? icon;
  final String? label;
  final void Function()? onPressed;
  final bool? isOutline;
  final Color primaryColor;
  final Color primaryTextColor;
  final double? radius;
  final bool? isLoading;
  final bool isDisabled;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    this.icon,
    this.label,
    this.onPressed,
    this.isOutline,
    this.primaryColor = primaryBackGroundBlack,
    this.primaryTextColor = primaryWhite,
    this.radius,
    this.isLoading,
    this.isDisabled = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final Color buttonColor = isOutline == true
        ? backgroundColor ?? Colors.transparent
        : (isDisabled ? primaryColor.withOpacity(0.9) : primaryColor);
    final Color borderColor =
        isOutline == true ? (primaryColor) : Colors.transparent;
    final Color? textColor = isOutline == true ? (primaryColor) : null;

    return ElevatedButton(
      onPressed: isDisabled == true ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8.0),
            side: isOutline == true
                ? BorderSide(color: borderColor)
                : BorderSide.none,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading == true)
              SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: textColor ?? primaryTextColor,
                ),
              )
            else
              const SizedBox.shrink(),
            SizedBox(width: isLoading == true ? 15 : 0),
            if (icon != null) ...[
              customSvgIcon(
                path: icon!,
                width: 25,
                height: 25,
                iconColor: textColor ?? primaryTextColor,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textColor ?? primaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
