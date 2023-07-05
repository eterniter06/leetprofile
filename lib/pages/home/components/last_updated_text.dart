import 'dart:async';

import 'package:flutter/material.dart';

class LastUpdatedText extends StatefulWidget {
  const LastUpdatedText({super.key, required this.lastUpdated});
  final DateTime lastUpdated;

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
      String singularForm = "day";
      String pluralForm = "${singularForm}s";
      String form = days > 1 ? pluralForm : singularForm;

      return "${duration.inDays.toString()} $form ago";
    } else if (hours > 0) {
      String singularForm = "hr";
      String pluralForm = "${singularForm}s";
      String form = hours > 1 ? pluralForm : singularForm;

      return "${duration.inHours.toString()} $form ago";
    } else if (minutes > 0) {
      String singularForm = "min";
      String pluralForm = "${singularForm}s";
      String form = minutes > 1 ? pluralForm : singularForm;

      return "${duration.inMinutes.toString()} $form ago";
    } else {
      return "now";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(_duration);
  }
}
