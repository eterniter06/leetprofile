import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ui_elements/database/user_database.dart';
import 'package:ui_elements/providers/profile_importing.dart';
import 'package:ui_elements/providers/settings.dart';
import 'package:ui_elements/providers/theme.dart';
import 'package:ui_elements/providers/user_list.dart';
import 'database/settings_database.dart';

import 'package:ui_elements/pages/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserDatabase.init();
  await SettingsDatabase.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserListModel()),
        ChangeNotifierProvider(create: (context) => ProfileImportStatus()),
        ChangeNotifierProvider(
          create: (context) =>
              ThemeModeModel(themeMode: SettingsDatabase.themeMode()),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsModel(
              showUsernameOnHomeScreen:
                  SettingsDatabase.showUsernameOnHomeScreen()),
        ),
      ],
      child: Consumer2<ThemeModeModel, UserListModel>(
        builder: (context, appThemeMode, userListModel, child) => MaterialApp(
          theme: ThemeModeModel.light,
          darkTheme: ThemeModeModel.dark,
          themeMode: appThemeMode.themeMode,
          home: HomePage(userListModel: userListModel),
        ),
      ),
    ),
  );
}
