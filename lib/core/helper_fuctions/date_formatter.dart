import 'package:intl/intl.dart';

class DateHelperFunctions {

  static String formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat('d MMM yyyy').format(dateTime);
    return formattedDate;
  }

  static  String timeAgo(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(dateTime);
    if (difference.isNegative) {
      return 'in ${_formatTimeDifference(difference)}';
    } else {
      return '${_formatTimeDifference(difference)} ago';
    }
  }

  static String _formatTimeDifference(Duration difference) {
    if (difference.inDays > 0) {
      return '${difference.inDays} days';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} min';
    } else {
      return 'just now';
    }
  }


  static String getRemainingDays(DateTime endDate) {
    final today = DateTime.now();
    final difference = endDate.difference(today).inDays;

    if (difference > 1) {
      return '$difference days remaining';
    } else if (difference == 1) {
      return '1 day remaining';
    } else if (difference == 0) {
      return 'Ends today';
    } else {
      final passed = difference.abs();
      if (passed == 1) {
        return 'Expired yesterday';
      } else {
        return 'Expired $passed days ago';
      }
    }
  }




}