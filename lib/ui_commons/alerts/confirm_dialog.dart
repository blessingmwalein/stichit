
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

Future<bool?> showCustomConfirmationDialog(BuildContext context, String title,
    String description, String iconPath) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        backgroundColor: CustomColors.white,
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 200,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: CustomColors.white,
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: customSvgIcon(path:iconPath, height: 40,width: 40, iconColor: Colors.red),
                  ),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                ],
              ),
              const SizedBox(height: 10),
              Text(description,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.8)),
                  textAlign: TextAlign.center),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      label:"Cancel",
                      isOutline: false,
                      primaryColor: Colors.red,
                      onPressed: () {
                        Navigator.of(context).pop(
                            false); // Return false when cancel button is pressed
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                      label:"Confirm",
                      isOutline: true,
                      primaryColor: CustomColors.orange,
                      backgroundColor: CustomColors.white,
                      onPressed: () {
                        Navigator.of(context).pop(
                            true); // Return true when confirm button is pressed
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
