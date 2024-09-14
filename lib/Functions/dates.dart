import 'package:intl/intl.dart';

String dateToHafen(String formattedString) {
  return formattedString.replaceAll("/", "-");
}

String getDate(String formattedString) {
  try {
    return DateFormat.yMd().format(DateTime.parse(formattedString));
  } catch (err) {
    return DateFormat.yMd().format(DateTime.now());
  }
}

getDateAndTime(String formattedString) {
  DateTime dateTime = DateTime.parse(formattedString);
  String time = DateFormat.jm().format(dateTime);
  String date = DateFormat.yMd().format(dateTime);
  return "$date $time";
}

getTime(String formattedString) {
  return DateFormat.jm().format(DateTime.parse(formattedString));
}

DateTime? isValidDate(String dateString) {
  try {
    return DateTime.parse(dateString);
  } catch (e) {
    return null;
  }
}
