import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';

class IconDropDownButton extends StatefulWidget {
  final List<String> items;
  final void Function(String?) onChanged;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;

  const IconDropDownButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.iconSize = 15.0,
    this.iconColor = CustomColors.grey,
    this.backgroundColor = CustomColors.lightBackGround,
  });

  @override
  State<IconDropDownButton> createState() => _IconDropDownButtonState();
}

class _IconDropDownButtonState extends State<IconDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: CustomColors.lightBackGround,
        icon: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            Icons.more_vert,
            size: widget.iconSize,
            color: widget.iconColor,
          ),
        ),
        onChanged: (String? newValue) {
          widget.onChanged(newValue);
        },
        items: widget.items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item,
                style: const TextStyle(fontSize: 14, color: CustomColors.grey)),
          );
        }).toList(),
      ),
    );
  }
}
