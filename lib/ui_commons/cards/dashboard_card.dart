import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class DashboardCard extends StatefulWidget {
  final String title;
  final String icon;
  final String total;
  const DashboardCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.total});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: const BoxDecoration(
          color: CustomColors.dashboardbackColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: CustomColors.lightBackGround,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: customSvgIcon(
                        path: widget.icon,
                        width: 40,
                        height: 40,
                        iconColor: CustomColors.white.withOpacity(0.8)),
                  ),
                
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, bottom: 10.0),
                    child: Text(
                      widget.total,
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
