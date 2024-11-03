import 'package:intl/intl.dart';

class HelperDate {
  HelperDate._instance();

  static String formatDateyMMMd(DateTime date) {
    return DateFormat.yMMMd('es_MX').format(date);
  }
}
