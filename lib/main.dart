import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_elements/providers/settings.dart';

import 'package:ui_elements/providers/user_list.dart';
import 'package:ui_elements/database/user_database.dart';
import 'package:ui_elements/providers/theme.dart';

import 'database/settings_database.dart';

import 'package:ui_elements/pages/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserDatabase.init();
  await SettingsDatabase.init();

  // Todo: Refactor below code into settingsDatabase
  SharedPreferences pref = await SettingsDatabase.sharedPreferences();

  String? themeModePreference = pref.getString('themeMode');

  if (themeModePreference == null) {
    SettingsDatabase.changeTheme(ThemeMode.system);
    themeModePreference = ThemeMode.system.toString();
  }

  ThemeMode startupThemeMode =
      ThemeModeModel.themeModeFromString(themeModePreference);
  bool showUsernameOnHomeScreen = SettingsDatabase.showUsernameOnHomeScreen();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeModeModel(themeMode: startupThemeMode),
        ),
        ChangeNotifierProvider(
          create: (context) => UserListModel(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SettingsModel(showUsernameOnHomeScreen: showUsernameOnHomeScreen),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
