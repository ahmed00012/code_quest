import 'package:intl/intl.dart';

extension StringExtension on String {
  String toFormattedDateTime() {
    return DateFormat('EEE  yyyy-MM-dd  hh:mm a').format(DateTime.parse(this));
  }
}
