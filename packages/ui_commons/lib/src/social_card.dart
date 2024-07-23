import 'package:flutter/material.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    required this.socialName,
    this.link,
    required this.isSet, // Add BuildContext parameter
    this.onChanged,
    Key? key,
  }) : super(key: key);

  final String socialName;
  final String? link;
  final bool isSet;
  final void Function(bool)? onChanged; // Context to pass

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Call onChanged with the value and context
        onChanged?.call(true);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.black, width: 1), // Add border
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  socialName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  link ?? 'Not set',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Switch(
              value: isSet,
              onChanged: (value) {
                // Call onChanged with both the value and context
                onChanged?.call(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
