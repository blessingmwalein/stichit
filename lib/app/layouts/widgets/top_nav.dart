import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class TopNavBar extends StatelessWidget {
  final List<String> crumbs;
  const TopNavBar({super.key, required this.crumbs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColors.white.withOpacity(0.4),
            width: 0.3,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Breadcrumb
          Row(
            children: crumbs
                .map((crumb) => Row(
                      children: [
                        TextButton(
                          onPressed: (){},
                          child: Text(
                            crumb,
                            style:  TextStyle(
                              color: crumb == crumbs.last ? CustomColors.white : CustomColors.white.withOpacity(0.5),
                              fontSize: 18,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                        if (crumb != crumbs.last)
                           Icon(Icons.chevron_right, color: CustomColors.white.withOpacity(0.7), ),
                      ],
                    ))
                .toList(),
          ),
          // Search Form
          Row(
            children: [
              Container(
                // padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: CustomColors.lightGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: CustomColors.white.withOpacity(0.5),fontSize: 14),
                    filled: true,
                    fillColor: CustomColors.lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    // contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customSvgIcon(path: "assets/icons/search.svg", width: 10, height: 10, iconColor: CustomColors.white.withOpacity(0.5)),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customSvgIcon(path: "assets/icons/terminal.svg", width: 10, height: 10, iconColor: CustomColors.white.withOpacity(0.5)),
                    )
                  ),
                  style: const TextStyle(color: CustomColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
