import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ui_elements/providers/theme.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/common_components/circular_network.dart';
import 'package:ui_elements/pages/home/components/last_updated_text.dart';

import 'package:ui_elements/providers/settings.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userData});
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Selector<SettingsModel, bool>(
        selector: (context, settingsModel) => settingsModel.showUsername,
        builder: (context, showUserName, child) => ListTile(
          tileColor: ThemeModeModel.lightBackground,
          leading: CircularNetworkImage(imageLink: userData.avatar),
          title: Text(userData.nickname ??
              (userData.realname == ""
                  ? userData.username
                  : userData.realname)),
          trailing: LastUpdatedText(lastUpdated: userData.lastFetchTime),
          subtitle: showUserName
              ? Text(
                  userData.username,
                  style: const TextStyle(
                    fontSize: 12,
                    inherit: true,
                    color: ThemeModeModel.lightSecondaryInverse,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
