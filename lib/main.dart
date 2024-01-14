import 'package:flutter/material.dart';

import 'package:ui_elements/database/user_database.dart';
import 'database/settings_database.dart';

import 'package:ui_elements/pages/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserDatabase.init();
  await SettingsDatabase.init();

  runApp(const LeetProfile());
}
