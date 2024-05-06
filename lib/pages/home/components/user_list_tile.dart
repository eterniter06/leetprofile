import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ui_elements/providers/theme.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/common_components/widgets/circular_image.dart';
import 'package:ui_elements/common_components/widgets/last_updated_text.dart';

import 'package:ui_elements/providers/settings.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userData, this.openView});
  final UserData userData;
  final Function? openView;

  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);

    return Material(
      child: Selector<SettingsModel, bool>(
        selector: (context, settingsModel) => settingsModel.showUsername,
        builder: (context, showUserName, child) => ListTile(
          leading: CircularImage(imageLink: userData.avatar),
          title: Text(userData.displayName()),
          trailing: LastUpdatedText(lastUpdated: userData.lastFetchTime),
          subtitle: showUserName
              ? Consumer<ThemeModeModel>(
                  builder: (context, themeModeModel, child) => Text(
                    userData.username,
                    style: TextStyle(
                      fontSize: 12,
                      inherit: true,
                      color: themeModeModel
                                  .equivalentThemeMode(platformBrightness) ==
                              ThemeMode.light
                          ? ThemeModeModel.lightSecondaryInverse
                          : ThemeModeModel.lightPrimary,
                    ),
                  ),
                )
              : null,
          onTap: () => openView?.call(),
        ),
      ),
    );
  }
}
