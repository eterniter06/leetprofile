import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dataclass/user_class/userdata.dart';
import '../theme.dart';

const String database = 'users.db';

class UserDatabase {
  UserDatabase._();

  static Isar? _isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [UserDataSchema],
      directory: dir.path,
    );
  }

  static Future<IsarCollection<UserData>?> database() async {
    if (_isar == null) init();
    return _isar?.collection<UserData>();
  }

  static Future<Isar?> isar() async {
    if (_isar == null) init();
    return _isar;
  }

  static Future<int> size() async {
    if (_isar == null) init();
    return _isar!.collection<UserData>().count();
  }

  static Future<void> put(UserData user) async {
    var isar = await UserDatabase.isar();
    await isar!.writeTxn(() async {
      await UserDatabase.database().then((db) => db!.put(user));
    });
  }

  static Future<void> putAll(List<UserData> userList) async {
    var isar = await UserDatabase.isar();
    await isar!.writeTxn(() => isar.userDatas.putAll(userList));
  }

  static Future<void> delete(UserData user) async {
    var isar = await UserDatabase.isar();
    await isar!.writeTxn(() async {
      await isar.userDatas.delete(user.isarId);
    });
  }
}

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
}
