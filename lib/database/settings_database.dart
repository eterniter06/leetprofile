import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../change_notifiers/theme.dart';

class SettingsDatabase {
  SettingsDatabase._();

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> sharedPreferences() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// initSharedPrefs() must have been called at least once before calling.
  static ThemeMode themeMode() {
    assert(_prefs != null);
    return ThemeModeModel.themeModeFromString(_prefs!.getString('themeMode'));
  }

  static Future<void> changeTheme(ThemeMode chosenTheme) async {
    await _prefs!.setString('themeMode', chosenTheme.toString());
  }

  static Future<void> changeRefreshAllUsersOnStartup(bool loadOnStartup) async {
    await _prefs!.setBool('refreshAllUsersOnStartup', loadOnStartup);
  }

  /// initSharedPrefs() must have been called at least once before calling.
  static bool refreshAllUsersOnStartup() {
    assert(_prefs != null);
    bool? preference = _prefs!.getBool('refreshAllUsersOnStartup');

    if (preference == null) {
      changeRefreshAllUsersOnStartup(true);
      return true;
    }

    return preference;
  }

  static Future<void> changeNumberOfShownUserSubmissions(
      int submissionCount) async {
    await _prefs!.setInt('submissionsToShow', submissionCount);
  }

  static int numberOfShownUserSubmissions() {
    int? count = _prefs!.getInt('submissionsToShow');

    if (count == null) {
      int defaultSubmissionCount = 3;
      changeNumberOfShownUserSubmissions(defaultSubmissionCount);
      return defaultSubmissionCount;
    }

    return count;
  }
}
