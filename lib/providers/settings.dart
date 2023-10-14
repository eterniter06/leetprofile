import 'package:flutter/material.dart';
import 'package:ui_elements/database/settings_database.dart';

class SettingsModel extends ChangeNotifier {
  bool _showUsernameOnHomeScreen;

  SettingsModel({required bool showUsernameOnHomeScreen})
      : _showUsernameOnHomeScreen = showUsernameOnHomeScreen;

  void toggleUsernameOnHomeScreenVisibility() async {
    _showUsernameOnHomeScreen = !_showUsernameOnHomeScreen;
    notifyListeners();
    await SettingsDatabase.changeShowUsernameOnHomeScreen(
        _showUsernameOnHomeScreen);
  }

  get showUsername => _showUsernameOnHomeScreen;

  // Other settings(excluding theming which is separated and triggers
  // a rebuild) are not included because they do not change anything
  // on the home screen which would require a rebuild to reflect changes.

  // Take the number of tags shown for example; The widget that depends
  // on that number is not in the widget tree when the value is changed
  // (Widget in UserView and UserView.reorderable; whereas value is
  // changed in the settings page; at which point no instance UserView
  // is built)
}
