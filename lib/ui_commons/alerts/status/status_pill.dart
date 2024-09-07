import 'package:flutter/material.dart';

class StatusPill extends StatelessWidget {
  final String status;

  const StatusPill({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the background color based on the status
    Color backgroundColor = _getBackgroundColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper method to get background color based on the order status
  Color _getBackgroundColor(String status) {
    switch (status) {
      case 'Created':
        return Colors.green; // Green for 'Created'
      case 'Received':
        return Colors.blue; // Blue for 'Received'
      case 'Processed':
        return Colors.orange; // Orange for 'Processed'
      case 'In Progress':
        return Colors.purple;
      case 'Done':
        return Colors.blue; // Purple for 'In Progress'
      case 'Delivered':
        return Colors.grey; // Grey for 'Delivered'
      default:
        return Colors.black; // Fallback color
    }
  }
}
