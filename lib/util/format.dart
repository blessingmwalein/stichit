import 'package:intl/intl.dart';

class DateFormatter {
  // Static method to format date string
  static String formatDateString(String dateString) {
    try {
      // Parse the ISO 8601 date string
      final DateTime dateTime = DateTime.parse(dateString);

      // Format the DateTime object to a readable string
      final String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      // Handle any parsing or formatting errors
      print('Error formatting date: $e');
      return 'Invalid date';
    }
  }
}
