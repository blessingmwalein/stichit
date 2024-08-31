import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class CustomDatePickerWidget extends StatefulWidget {
  const CustomDatePickerWidget({
    super.key,
    required this.label,
    required this.initialDate,
    required this.onDateChanged,
    this.isOutline = false,
    this.primaryColor, // Added primaryColor parameter for custom color
  });

  final String label;
  final DateTime initialDate;
  final Function(DateTime) onDateChanged;
  final bool isOutline;
  final Color? primaryColor; // Primary color for text and border

  @override
  _CustomDatePickerWidgetState createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = widget.primaryColor ?? primaryWhite;

    return InkWell(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
          widget.onDateChanged(pickedDate);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: primaryColor,
          ),
          filled: !widget.isOutline,
          fillColor: lightBlackForm,
          enabledBorder: widget.isOutline
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(
                    color: primaryColor.withOpacity(0.7),
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(
                    color: primaryColor.withOpacity(0.2),
                  ),
                ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: BorderSide(
              width: 1.0,
              color: primaryColor.withOpacity(0.7),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0), // Adjust padding as needed
            child: customSvgIcon(
              path: "assets/icons/calendar-outlined.svg",
              iconColor: primaryColor.withOpacity(0.7),
              width: 20,
              height: 20,
            ),
          ),
        ),
        child: Text(
          '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
          style: TextStyle(color: primaryColor.withOpacity(0.7)),
        ),
      ),
    );
  }
}
