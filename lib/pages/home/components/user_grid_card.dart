import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/common_components/widgets/circular_image.dart';
import 'package:ui_elements/common_components/widgets/last_updated_text.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/providers/settings.dart';
import 'package:ui_elements/providers/theme.dart';

class UserGridCard extends StatelessWidget {
  const UserGridCard({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Selector<SettingsModel, bool>(
      selector: (context, settingsModel) => settingsModel.showUsername,
      builder: (context, showUsername, child) => Stack(
        children: [
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CircularImage(
                    //TODO: use radius as per card width
                    radius: 42,
                    imageLink: user.avatar,
                  ),
                ),
                Text(user.displayName()),
                if (showUsername)
                  Consumer<ThemeModeModel>(
                    builder: (context, themeModeModel, child) => Text(
                      user.username,
                      style: TextStyle(
                        fontSize: 12,
                        inherit: true,
                        color: themeModeModel.equivalentThemeMode(
                                    MediaQuery.platformBrightnessOf(context)) ==
                                ThemeMode.light
                            ? ThemeModeModel.lightSecondaryInverse
                            : ThemeModeModel.lightPrimary,
                      ),
                    ),
                  )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LastUpdatedText.short(
                  fontStyle: const TextStyle(fontSize: 10),
                  lastUpdated: user.lastFetchTime),
            ),
          ),
        ],
      ),
    );
  }
}
