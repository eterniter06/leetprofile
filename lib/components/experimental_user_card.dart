import 'package:flutter/material.dart';
import 'dataclass/user_class/userdata.dart';
import 'image/circular_network.dart';

class ExperimentalUserCard extends StatelessWidget {
  const ExperimentalUserCard({super.key, required this.userData});
  final UserData userData;

  Duration _lastUpdateDuration(DateTime lastUpdate) {
    Duration duration = DateTime.now().difference(lastUpdate);
    if (duration.inDays > 0) return Duration(days: duration.inDays);
    if (duration.inHours > 0) return Duration(hours: duration.inHours);
    if (duration.inMinutes > 0) return Duration(minutes: duration.inMinutes);

    return const Duration();
  }

  String _lastUpdateDurationAsString(DateTime lastUpdate) {
    Duration duration = _lastUpdateDuration(lastUpdate);

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
    return Material(
      child: ListTile(
        tileColor: const Color(0xff222222),
        style: ListTileStyle.list,
        leading: CircularNetworkImage(imageLink: userData.avatar),
        title: Text(userData.nickname),
        trailing: Text(
            _lastUpdateDurationAsString(userData.lastFetchTime).toString()),
        subtitle: Text(userData.username),
      ),
    );
  }
}
