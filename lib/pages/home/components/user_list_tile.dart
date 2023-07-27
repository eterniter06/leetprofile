import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/image/circular_network.dart';
import 'package:ui_elements/pages/home/components/last_updated_text.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userData});
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        style: ListTileStyle.list,
        leading: CircularNetworkImage(imageLink: userData.avatar),
        title: Text(userData.nickname ??
            (userData.realname == "" ? userData.username : userData.realname)),
        trailing: LastUpdatedText(lastUpdated: userData.lastFetchTime),
        subtitle: Text(userData.username),
      ),
    );
  }
}
