import 'dart:async';

import 'package:flutter/material.dart';

class LastUpdatedText extends StatefulWidget {
  const LastUpdatedText({super.key, required this.lastUpdated, this.fontStyle})
      : shortForm = false;

  const LastUpdatedText.short(
      {super.key, required this.lastUpdated, this.fontStyle})
      : shortForm = true;

  final DateTime lastUpdated;
  final TextStyle? fontStyle;
  final bool shortForm;

  @override
  State<LastUpdatedText> createState() => _LastUpdatedTextState();
}

class _LastUpdatedTextState extends State<LastUpdatedText> {
  late String _duration;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _duration = _lastUpdateDurationAsString(widget.lastUpdated).toString();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _duration = _lastUpdateDurationAsString(widget.lastUpdated).toString();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Duration _decreaseDurationPrecision(DateTime lastUpdate) {
    Duration duration = DateTime.now().difference(lastUpdate);
    if (duration.inDays > 0) return Duration(days: duration.inDays);
    if (duration.inHours > 0) return Duration(hours: duration.inHours);
    if (duration.inMinutes > 0) return Duration(minutes: duration.inMinutes);

    return const Duration();
  }

  String _lastUpdateDurationAsString(DateTime lastUpdate) {
    Duration duration = _decreaseDurationPrecision(lastUpdate);

    int days = duration.inDays;
    int hours = duration.inHours;
    int minutes = duration.inMinutes;

    if (days > 0) {
      const String singularForm = "day";
      const String pluralForm = "${singularForm}s";
      final String longForm = days > 1 ? pluralForm : singularForm;

      const String shortForm = "d";
      final String durationInDay = duration.inDays.toString();

      return widget.shortForm
          ? "$durationInDay$shortForm"
          : "$durationInDay $longForm ago";
    } else if (hours > 0) {
      const String singularForm = "hr";
      const String pluralForm = "${singularForm}s";
      final String longForm = hours > 1 ? pluralForm : singularForm;

      const String shortForm = "h";

      final String durationInHour = duration.inHours.toString();

      return widget.shortForm
          ? "$durationInHour$shortForm"
          : "$durationInHour $longForm ago";
    } else if (minutes > 0) {
      const String singularForm = "min";
      const String pluralForm = "${singularForm}s";
      final String longForm = minutes > 1 ? pluralForm : singularForm;

      const String shortForm = "m";
      final String durationInMinute = duration.inMinutes.toString();
      return widget.shortForm
          ? "$durationInMinute$shortForm"
          : "$durationInMinute $longForm ago";
    } else {
      return "now";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _duration,
      style: widget.fontStyle,
    );
  }
}
