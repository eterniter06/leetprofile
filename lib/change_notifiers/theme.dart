import 'package:flutter/material.dart';

class ThemeModeModel extends ChangeNotifier {
  ThemeModeModel({required ThemeMode themeMode}) : _themeMode = themeMode;

  ThemeMode _themeMode;
  get themeMode => _themeMode;

  void changeThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Overpass',
  );

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Overpass',
  );

  static ThemeMode themeModeFromString(String? modeAsString) {
    if (modeAsString == ThemeMode.dark.toString()) {
      return ThemeMode.dark;
    } else if (modeAsString == ThemeMode.light.toString()) {
      return ThemeMode.light;
    } else if (modeAsString == ThemeMode.system.toString()) {
      return ThemeMode.system;
    } else {
      throw "Invalid value for ThemeMode: $modeAsString";
    }
  }
}
