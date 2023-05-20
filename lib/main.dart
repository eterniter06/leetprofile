import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_elements/components/database/user_database.dart';
import 'package:ui_elements/components/theme.dart';
import 'components/database/settings_database.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserDatabase.init();

  await SettingsDatabase.init();
  SharedPreferences pref = await SettingsDatabase.sharedPreferences();
  ThemeMode startupThemeMode =
      ThemeModeModel.themeModeFromString(pref.getString('themeMode'));

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeModeModel(themeMode: startupThemeMode),
    child: const MyApp(),
  ));
}
