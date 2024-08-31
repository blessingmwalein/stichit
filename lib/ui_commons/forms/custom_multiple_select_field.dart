import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';

class CustomMultiSelectTextFieldWidget<T> extends StatefulWidget {
  const CustomMultiSelectTextFieldWidget({
    super.key,
    required this.label,
    this.controller,
    this.textInputType,
    this.options,
    required this.selectedOptions,
    this.isDisabled,
    this.onChanged,
    this.isOutline = false,
    this.bindValue,
    this.bindName,
    this.primaryColor = CustomColors.white,
    this.borderColor = CustomColors.white,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final List<T>? options;
  final List<T> selectedOptions;
  final bool? isDisabled;
  final void Function(List<T>)? onChanged;
  final bool isOutline;
  final String? bindValue;
  final String? bindName;
  final Color primaryColor; // Optional primary color
  final Color borderColor; // Optional border color

  @override
  CustomMultiSelectTextFieldWidgetState<T> createState() =>
      CustomMultiSelectTextFieldWidgetState<T>();
}

class CustomMultiSelectTextFieldWidgetState<T>
    extends State<CustomMultiSelectTextFieldWidget<T>> {
  late List<T> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List.from(widget.selectedOptions);
  }

  String getDisplayText(T? option) {
    if (option == null) return '';

    if (option is Map<String, dynamic>) {
      // If option is a map, try to extract text using bindName
      final dynamic name = option[widget.bindName ?? ''];
      return name != null ? name.toString() : '';
    } else if (option is String) {
      // If option is a string, simply return the string
      return option;
      // ignore: unnecessary_type_check
    } else if (option is Object) {
      // If option is a custom object, try to extract text using reflection
      final dynamic name =
          // ignore: unnecessary_type_check
          option is Object ? (option as dynamic)[widget.bindName ?? ''] : '';
      return name != null ? name.toString() : '';
    }

    // Return empty string if unable to extract display text
    return '';
  }

  void _onOptionSelected(T? option) {
    if (option != null && !_selectedOptions.contains(option)) {
      setState(() {
        _selectedOptions.add(option);
      });
      if (widget.onChanged != null) {
        widget.onChanged!(_selectedOptions);
      }
    }
  }

  void _removeSelectedOption(T option) {
    setState(() {
      _selectedOptions.remove(option);
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_selectedOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<T>(
          value: null,
          onChanged: widget.isDisabled == true ? null : _onOptionSelected,
          focusColor: widget.primaryColor.withOpacity(0.7),
          style: TextStyle(color: widget.primaryColor.withOpacity(0.7)),
          dropdownColor: CustomColors.darkBackGround,
          decoration: InputDecoration(
            labelText: widget.label,
            focusColor: widget.primaryColor,
            filled: !widget.isOutline,
            fillColor: widget.isOutline ? null : CustomColors.darkBackGround,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            labelStyle: TextStyle(color: widget.primaryColor),
            hintStyle: TextStyle(
              color: widget.primaryColor.withOpacity(0.7),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(width: 1.0, color: widget.borderColor),
            ),
            enabledBorder: widget.isOutline
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                      color: widget.borderColor,
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
                color: widget.borderColor,
              ),
            ),
          ),
          items: widget.options?.map<DropdownMenuItem<T>>((T? option) {
            return DropdownMenuItem<T>(
              value: option,
              child: Text(getDisplayText(option)),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _selectedOptions.map((T option) {
            return Chip(
              label: Text(getDisplayText(option)),
              onDeleted: () => _removeSelectedOption(option),
              deleteIcon: const Icon(Icons.close),
              deleteIconColor: Colors.red,
            );
          }).toList(),
        ),
      ],
    );
  }
}
