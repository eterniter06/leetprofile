import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_elements/components/database/user_database.dart';
import 'package:ui_elements/components/change_notifiers/theme.dart';
import 'package:ui_elements/pages/home.dart';
import 'components/database/settings_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserDatabase.init();

  await SettingsDatabase.init();
  SharedPreferences pref = await SettingsDatabase.sharedPreferences();

  String? themeModePreference = pref.getString('themeMode');

  if (themeModePreference == null) {
    SettingsDatabase.changeTheme(ThemeMode.system);
    themeModePreference = ThemeMode.system.toString();
  }

  ThemeMode startupThemeMode =
      ThemeModeModel.themeModeFromString(themeModePreference);

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeModeModel(themeMode: startupThemeMode),
    child: const MyApp(),
  ));
}
