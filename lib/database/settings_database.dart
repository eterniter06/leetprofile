import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/theme.dart';

class SettingsDatabase {
  SettingsDatabase._();

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// initSharedPrefs() must have been called at least once before calling.
  static ThemeMode themeMode() {
    String? modeAsString = _prefs!.getString('themeMode');

    if (modeAsString == null) {
      changeTheme(ThemeMode.system);
      modeAsString = ThemeMode.system.toString();
    }
    return ThemeModeModel.themeModeFromString(modeAsString);
  }

  static Future<void> changeTheme(ThemeMode chosenTheme) async {
    await _prefs!.setString('themeMode', chosenTheme.toString());
  }

  static Future<void> changeRefreshAllUsersOnStartup(bool loadOnStartup) async {
    await _prefs!.setBool('refreshAllUsersOnStartup', loadOnStartup);
  }

  /// initSharedPrefs() must have been called at least once before calling.
  ///
  /// Defaults to [true] if the user has not set their preference yet
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

  static List<String>? profileComponentOrder() {
    return _prefs!.getStringList('profileComponentOrder');
  }

  static Future<void> saveProfileComponentsOrder(List<String> order) async {
    await _prefs!.setStringList('profileComponentOrder', order);
  }

  static Future<void> changeNumberOfShownTags(int tags) async {
    await _prefs!.setInt('tagsToShow', tags);
  }

  static int numberOfShownTags() {
    int? count = _prefs!.getInt('tagsToShow');

    if (count == null) {
      int defaultSubmissionCount = 4;
      changeNumberOfShownUserSubmissions(defaultSubmissionCount);
      return defaultSubmissionCount;
    }
    return count;
  }

  static Future<void> changeShowUsernameOnHomeScreen(bool isShown) async {
    await _prefs!.setBool('showUsernamesOnHomeScreen', isShown);
  }

  static bool showUsernameOnHomeScreen() {
    assert(_prefs != null);
    bool? preference = _prefs!.getBool('showUsernamesOnHomeScreen');

    if (preference == null) {
      bool defaultOption = true;
      changeShowUsernameOnHomeScreen(defaultOption);
      preference = defaultOption;
    }

    return preference;
  }

  static void set24HourFormat(bool is24HourFormat) {
    _prefs!.setBool('is24Hour', is24HourFormat);
  }

  static bool is24HourFormat() {
    bool? preference = _prefs!.getBool('is24Hour');

    if (preference == null) {
      bool defaultOption = true;
      set24HourFormat(defaultOption);
      preference = defaultOption;
    }

    return preference;
  }

  static Future<void> setShowSkillPieChart(bool showPieChart) async {
    await _prefs!.setBool('showSkillPieChart', showPieChart);
  }

  static bool showSkillPieChart() {
    bool? preference = _prefs!.getBool('showSkillPieChart');

    if (preference == null) {
      bool defaultOption = false;
      setShowSkillPieChart(defaultOption);
      preference = defaultOption;
    }

    return preference;
  }
}
