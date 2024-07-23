// ignore_for_file: public_member_api_docs, use_super_parameters, always_put_required_named_parameters_first, unnecessary_await_in_return

import 'package:flutter/material.dart';

class BlingDialog extends StatelessWidget {
  const BlingDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.actionButtons,
  }) : super(key: key);
  final String title;
  final String description;
  final String iconPath;
  final List<Widget> actionButtons;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.asset(
                    iconPath,
                    width: 40,
                    height: 40,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.green, // Change color as needed
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.green.withOpacity(0.8), // Change color as needed
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              children: actionButtons,
            )
          ],
        ),
      ),
    );
  }
}

Future<bool?> showCustomConfirmationDialog(
  BuildContext context,
  String title,
  String description,
  String iconPath,
  List<Widget> actionButtons,
) async {
  return await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return BlingDialog(
        title: title,
        description: description,
        iconPath: iconPath,
        actionButtons: actionButtons,
      );
    },
  );
}
