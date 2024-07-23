import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class DropDownButton extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final void Function(String?) onChanged;
  final String? icon;
  final Color? backgroundColor;
  final bool? isOutlined;
  final double radius;
  final double? width;
  final double? height;
  final bool? isIcon;

  const DropDownButton({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.backgroundColor,
    this.isOutlined,
    this.radius = 10,
    this.width,
    this.height,
    this.icon,
    this.isIcon,
  });

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          selectedItemBuilder: (context) {
            return widget.items.map((String item) {
              return widget.isIcon ?? false ? const SizedBox(): Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Create $item',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList();
          },
          // hint: Row(
          //   children: [
          //     if (widget.isIcon == true && widget.icon != null)
          //       customSvgIcon(
          //         path: widget.icon!,
          //         width: 20,
          //         height: 20,
          //         iconColor: Colors.yellow,
          //       ),
          //     if (widget.isIcon != true) const SizedBox(width: 4),
          //     if (widget.isIcon != true)
          //       const Expanded(
          //         child: Text(
          //           'Select Item',
          //           style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.yellow,
          //           ),
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //       ),
          //   ],
          // ),
          items: widget.items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: widget.selectedValue,
          onChanged: (String? value) {
            setState(() {
              widget.onChanged(value);
            });
          },
          buttonStyleData: ButtonStyleData(
            height: widget.height ?? 50,
            width: widget.width ?? 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: widget.backgroundColor ?? CustomColors.orange,
              border: widget.isOutlined == true
                  ? Border.all(color: CustomColors.grey)
                  : null,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.add,
              size: 20,
            ),
            iconSize: 14,
            iconEnabledColor: CustomColors.white,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: CustomColors.lightBackGround,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all<double>(6),
              thumbVisibility: WidgetStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
