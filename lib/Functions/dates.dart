import 'package:intl/intl.dart';

String dateToHafen(String formattedString) {
  return formattedString.replaceAll("/", "-");
}

String getDate(String formattedString) {
  return DateFormat.yMd(DateTime.parse(formattedString)).toString();
}

getDateAndTime(String formattedString) {
  DateTime dateTime = DateTime.parse(formattedString);
  String time = DateFormat.jm(dateTime).toString();
  String date = DateFormat.yMd(dateTime).toString();
  return "$date $time";
}

getTime(String formattedString) {
  return DateFormat.jm(formattedString).toString();
}
