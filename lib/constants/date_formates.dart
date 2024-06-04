import 'package:intl/intl.dart';

class DateFormate {
  static DateFormat displayDateFormate = DateFormat("dd MMM, yyyy");

  static DateFormat normalDateFormate = DateFormat('dd/MM/yyyy');
  static DateFormat databaseFormate =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  static DateFormat onlyTimeFormate = DateFormat('hh:mm:ss a');

  static DateFormat databaseDateFormate = DateFormat('MM/dd/yyyy hh:mm:ss a');
  static DateFormat longDateFormate = DateFormat('MMMM d, EEEE');
  static DateFormat tipsDateFormate = DateFormat('hh:mm | dd-MM-yyyy');

  static DateFormat newDateFormate = DateFormat('dd-MM-yyyy');

  static DateFormat onlyMonthFormate = DateFormat('MMM dd');
}

String dateDifference(String? dateInString) {
  if (DateTime.tryParse(dateInString ?? "-") == null) {
    return "-";
  }

  DateTime date = DateTime.parse(dateInString!)
      .toLocal(); // Parse and convert to local time
  DateTime now = DateTime.now();

  Duration difference = now.difference(date);
  String differenceString = '-';

  if (difference.inSeconds < 60) {
    differenceString = '${difference.inSeconds} second ago';
  } else if (difference.inMinutes < 60) {
    differenceString = '${difference.inMinutes} minute ago';
  } else if (difference.inHours < 24) {
    differenceString = '${difference.inHours} hour ago';
  } else {
    int days = difference.inDays;
    if (days == 1) {
      differenceString = '1 day ago';
    } else {
      differenceString = '$days days ago';
    }
  }

  return differenceString;
}
