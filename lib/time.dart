import 'package:intl/intl.dart';
import 'package:ui_elements/database/settings_database.dart';

class Time {
  static String orindal(DateTime submissionTime) {
    final day = int.parse(DateFormat('dd').format(submissionTime));
    if (day >= 10 && day <= 20) return "th";

    return day % 10 == 1
        ? "st"
        : day % 10 == 2
            ? "nd"
            : day % 10 == 3
                ? "rd"
                : "th";
  }

  static String timeOfDay(String epochInSeconds) {
    final submissionTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(epochInSeconds) * Duration.millisecondsPerSecond)
        .toLocal();

    String hour24 = "HH:mm:ss";
    String hour12 = "hh:mm:ss a";

    return DateFormat(SettingsDatabase.is24HourFormat() ? hour24 : hour12)
        .format(submissionTime);
  }

  static String dateLong(String epochsInSeconds) {
    final submissionTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(epochsInSeconds) * Duration.millisecondsPerSecond)
        .toLocal();

    final sumbissionOrdinal = Time.orindal(submissionTime);
    final dateTimeFormatter = DateFormat("dd'$sumbissionOrdinal' MMMM yyyy");

    return dateTimeFormatter.format(submissionTime);
  }

  static String dateShort(String epochsInSeconds) {
    final submissionTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(epochsInSeconds) * Duration.millisecondsPerSecond)
        .toLocal();

    final sumbissionOrdinal = Time.orindal(submissionTime);
    final dateTimeFormatter = DateFormat("dd'$sumbissionOrdinal' MMM yyyy");

    return dateTimeFormatter.format(submissionTime);
  }
}
