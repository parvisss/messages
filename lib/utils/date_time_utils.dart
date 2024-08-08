import 'package:intl/intl.dart';

String formatDateTime(String dateString) {
  try {
    final dateTime = DateTime.parse(dateString);
    final dateFormat = DateFormat('MMM d, yyyy, h:mm a');
    return dateFormat.format(dateTime);
  } catch (e) {
    print("Error formatting date: $e");
    return dateString;
  }
}
