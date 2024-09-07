import 'package:intl/intl.dart';

class DateFormatter {
  // Static method to format date string
  static String formatDateString(String dateString,
      {bool includeTime = false}) {
    try {
      // Parse the ISO 8601 date string
      final DateTime dateTime = DateTime.parse(dateString);

      // Format the DateTime object to a readable string
      final String dateFormat = 'd MMMM yyyy';
      final String timeFormat = 'h:mm a';

      // Format both date and time if includeTime is true
      final String formattedDate = includeTime
          ? DateFormat('$dateFormat at $timeFormat').format(dateTime)
          : DateFormat(dateFormat).format(dateTime);

      return formattedDate;
    } catch (e) {
      // Handle any parsing or formatting errors
      print('Error formatting date: $e');
      return 'No Date';
    }
  }
}
