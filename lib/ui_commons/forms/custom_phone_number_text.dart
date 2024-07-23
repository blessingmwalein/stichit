import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class CustomPhoneNumberText extends StatefulWidget {
  final String labelText;
  final String initialCountryCode;
  final ValueChanged<PhoneNumber>? onChanged;
  final bool isOutline;
  final String? suffixIconPath; // Added suffixIconPath parameter for SVG icon

  const CustomPhoneNumberText({
    super.key,
    required this.labelText,
    required this.initialCountryCode,
    this.onChanged,
    this.isOutline =
        false, // Added isOutline parameter with default value false
    this.suffixIconPath,
  });

  @override
  State<CustomPhoneNumberText> createState() => _CustomPhoneNumberTextState();
}

class _CustomPhoneNumberTextState extends State<CustomPhoneNumberText> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: widget.initialCountryCode,
      dropdownIcon: const Icon(Icons.arrow_drop_down, color: primaryWhite),
      dropdownTextStyle: const TextStyle(color: primaryWhite),
      style: TextStyle(color: primaryWhite.withOpacity(0.7)),
      decoration: InputDecoration(
        labelText: widget.labelText,
        filled: !widget.isOutline,
        helperStyle: const TextStyle(color: primaryWhite),
        fillColor: lightBlackForm,
        focusColor: primaryWhite,
        labelStyle: TextStyle(color: primaryWhite.withOpacity(0.7)),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(width: 1.0, color: lightBlackForm),
        ),
        enabledBorder: widget.isOutline
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: primaryWhite.withOpacity(0.2),
                ),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide.none,
              ),
        hintStyle: TextStyle(
          color: primaryWhite.withOpacity(0.7),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(width: 2.0, color: lightBlackForm),
        ),
        suffixIcon: widget.suffixIconPath != null
            ? Padding(
                padding: const EdgeInsets.all(12.0), // Adjust padding as needed
                child: customSvgIcon(
                  path: widget.suffixIconPath!,
                  iconColor: primaryWhite.withOpacity(0.7),
                  width: 20,
                  height: 20,
                ),
              )
            : null,
      ),
      onChanged: widget.onChanged,
    );
  }
}
