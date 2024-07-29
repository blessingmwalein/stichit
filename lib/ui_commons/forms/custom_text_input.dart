import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.isPassword,
    this.controller,
    this.textInputType,
    this.errorText,
    this.onChanged,
    this.defaultValue,
    this.isEnabled = true,
    this.suffixIconPath,
    this.isOutline = false,
    this.maxLines, // Added maxLines parameter for multi-line text fields
  });

  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final String? defaultValue;
  final bool isEnabled;
  final String? suffixIconPath;
  final bool isOutline;
  final int? maxLines; // Nullable parameter for the number of lines

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late TextEditingController _textEditingController;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ?? TextEditingController();
    _textEditingController.text = widget.defaultValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      enabled: widget.isEnabled,
      obscureText: widget.isPassword && _obscureText,
      onChanged: widget.onChanged,
      keyboardType: widget.textInputType,
      scrollPadding: EdgeInsets.zero,
      style: TextStyle(color: primaryWhite.withOpacity(0.7)),
      maxLines: widget.maxLines ?? 1, // Set maxLines with a default value of 1
      minLines: widget.maxLines ?? 1, // Set minLines for proper height
      decoration: InputDecoration(
        filled: !widget.isOutline,
        fillColor: lightBlackForm,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: widget.isEnabled ? primaryWhite : Colors.grey,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: widget.isEnabled ? primaryWhite.withOpacity(0.7) : Colors.grey,
        ),
        errorText: widget.errorText,
        errorStyle: const TextStyle(color: Colors.yellow),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide:
              BorderSide(width: 2.0, color: primaryWhite.withOpacity(0.7)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: primaryWhite.withOpacity(0.2),
          ),
        ),
        enabledBorder: widget.isOutline
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                    width: 2.0, color: primaryWhite.withOpacity(0.7)),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: primaryWhite.withOpacity(0.2),
                ),
              ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          // borderSide: BorderSide.none,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                padding: const EdgeInsets.all(20),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: primaryWhite,
                ),
              )
            : (widget.suffixIconPath != null
                ? Padding(
                    padding:
                        const EdgeInsets.all(12.0), // Adjust padding as needed
                    child: customSvgIcon(
                      path: widget.suffixIconPath!,
                      iconColor: primaryWhite.withOpacity(0.7),
                      width: 20,
                      height: 20,
                    ),
                  )
                : null),
      ),
    );
  }
}
