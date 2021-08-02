import 'package:intl/intl.dart';

class DateFormatter {

  final dateFormatter = DateFormat('dd.MM.yyyy');

  DateTime toDate(String birthday) {
    DateTime date = DateFormat("dd.MM.yyyy").parseLoose(birthday);
    return date;
  }

  String fromDate(stringDate) {
    var date = dateFormatter.format(DateTime.tryParse(stringDate).toLocal());
    return date.toString();
  }
}