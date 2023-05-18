import 'package:flutter/material.dart';
import 'dataclass/user_class/userdata.dart';
import 'image/circular_network.dart';
import 'last_updated_text.dart';

class ExperimentalUserCard extends StatelessWidget {
  const ExperimentalUserCard({super.key, required this.userData});
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        tileColor: const Color(0xff222222),
        style: ListTileStyle.list,
        leading: CircularNetworkImage(imageLink: userData.avatar),
        title: Text(userData.nickname),
        trailing: LastUpdatedText(lastUpdated: userData.lastFetchTime),
        subtitle: Text(userData.username),
      ),
    );
  }
}
