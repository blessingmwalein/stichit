import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class NoDataPage extends StatelessWidget {
  final String? message;
  const NoDataPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customSvgIcon(
              path: "assets/illustrations/undraw_no_data_re_kwbl.svg",
              width: 200,
              height: 200),
          const SizedBox(height: 40),
          Text(
            message ?? 'No available data',
            style:  TextStyle(
              color:primaryWhite.withOpacity(0.5),
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
