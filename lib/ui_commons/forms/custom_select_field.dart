import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';

class CustomSelectTextFieldWidget<T> extends StatefulWidget {
  const CustomSelectTextFieldWidget({
    Key? key,
    required this.label,
    this.controller,
    this.textInputType,
    this.options,
    required this.selectedOption,
    this.isDisabled,
    this.onChanged,
    this.isOutline = false,
    this.bindValue,
    this.bindName,
  }) : super(key: key);

  final String label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final List<T>? options;
  final T selectedOption;
  final bool? isDisabled;
  final void Function(T?)? onChanged;
  final bool isOutline;
  final String? bindValue;
  final String? bindName;

  @override
  _CustomSelectTextFieldWidgetState<T> createState() =>
      _CustomSelectTextFieldWidgetState<T>();
}

class _CustomSelectTextFieldWidgetState<T>
    extends State<CustomSelectTextFieldWidget<T>> {
  String getDisplayText(T? option) {
    if (option == null) return '';

    if (option is Map<String, dynamic>) {
      // If option is a map, try to extract text using bindName
      final dynamic name = option[widget.bindName ?? ''];
      return name != null ? name.toString() : '';
    } else if (option is String) {
      // If option is a string, simply return the string
      return option;
    } else if (option is Object) {
      // If option is a custom object, try to extract text using reflection
      final dynamic name =
          option is Object ? (option as dynamic)[widget.bindName ?? ''] : '';
      return name != null ? name.toString() : '';
    }

    // Return empty string if unable to extract display text
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: widget.selectedOption,
      onChanged: widget.isDisabled == true ? null : widget.onChanged,
      focusColor: CustomColors.white.withOpacity(0.7),
      dropdownColor: lightBlackForm,
      style: TextStyle(color: primaryWhite.withOpacity(0.7)),
      decoration: InputDecoration(
        labelText: widget.label,
        focusColor: primaryOrange,
        filled: !widget.isOutline,
        fillColor: lightBlackForm,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        labelStyle: const TextStyle(
          color: primaryWhite,
        ),
        hintStyle: TextStyle(
          color: primaryWhite.withOpacity(0.7),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(width: 1.0, color: lightBlackForm),
        ),
        enabledBorder: widget.isOutline
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: primaryWhite.withOpacity(0.8),
                ),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            width: 1.0,
            color: primaryWhite.withOpacity(0.7),
          ),
        ),
      ),
      items: widget.options?.map<DropdownMenuItem<T>>((T? option) {
        return DropdownMenuItem<T>(
          value: option,
          child: Text(getDisplayText(option)),
        );
      }).toList(),
    );
  }
}
