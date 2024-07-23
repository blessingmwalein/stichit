import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';

class CopyTextButton extends StatelessWidget {
  final String text;
  const CopyTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: text));
          showCustomSnackbar(
            context,
            'Zvaita!',
            'Text copied to clipboard',
            ContentType.success,
          );
        },
        child: Row(
          children: [
            customSvgIcon(
                path: "assets/icons/clipboard-copy.svg",
                width: 25,
                height: 25,
                iconColor: CustomColors.grey),
            const SizedBox(width: 5),
            Text(
              text.length > 8 ? '${text.substring(0, 8)}...' : text,
              style: const TextStyle(
                color: CustomColors.grey,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }
}
