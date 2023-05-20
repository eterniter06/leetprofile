import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../components/database/database.dart';
import '../components/dataclass/http_wrapper/data_parser.dart';
import '../components/dataclass/user_class/userdata.dart';

class UserListModel extends ChangeNotifier {
  List<UserData> userList = [];

  bool _isInitialized = false;

  int length() {
    return userList.length;
  }

  bool inList(String username) {
    int index = userList.indexWhere((userInList) {
      return userInList.username == username;
    });

    return index != -1;
  }

  UserData? user(String username) {
    int index = userList.indexWhere((userInList) {
      return userInList.username == username;
    });

    return index != -1 ? userList[index] : null;
  }

  void addUser(UserData user) {
    int index = userList.indexWhere((userInList) {
      return userInList.username == user.username;
    });

    if (index == -1) {
      userList.add(user);
      notifyListeners();
    }
  }

  void insertUser(int index, UserData user) {
    int index = userList.indexWhere((userInList) {
      return userInList.username == user.username;
    });

    if (index == -1) {
      userList.insert(index, user);
      notifyListeners();
    }
  }

  Future<void> loadUsers() async {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;

    var isar = await UserDatabase.isar();
    var tempUserList = await isar!.userDatas
        .filter()
        .isarIdGreaterThan(Isar.minId)
        .sortByListOrder()
        .findAll();

    userList = tempUserList;
    notifyListeners();

    if (SettingsDatabase.refreshAllUsersOnStartup()) {
      await updateUsers();
      notifyListeners();
    }
  }

  Future<void> updateUser(UserData user) async {
    var dataMap = await DataParser(username: user.username).getAllAsJson();
    user.update(updatedUser: UserData.fromMap(dataMap: dataMap!));

    notifyListeners();
  }

  Future<void> updateUsers() async {
    List<Future> futureJsonList = [];
    for (var user in userList) {
      futureJsonList.add(DataParser(username: user.username).getAllAsJson());
    }

    var jsonList = await Future.wait(futureJsonList);

    for (int i = 0; i < userList.length; ++i) {
      userList[i].update(updatedUser: UserData.fromMap(dataMap: jsonList[i]));
    }

    notifyListeners();
  }

  Future<UserData?> createUserFromUsername(String username) async {
    Map? data = await DataParser(username: username).getAllAsJson();
    return data == null ? null : UserData.fromMap(dataMap: data);
  }

  void refreshListOrder() {
    bool didUpdate = false;

    for (int i = 0; i < userList.length; ++i) {
      if (userList[i].listOrder != i) {
        didUpdate = true;
        userList[i].listOrder = i;
      }
    }

    if (didUpdate) {
      notifyListeners();
    }
  }

  String exportUsernamesAsCSV({bool withTLD = false}) {
    String headerColumn = 'Username';

    String csv = headerColumn;
    String TLD = withTLD ? 'https://leetcode.com/' : '';

    for (var user in userList) {
      csv = "$csv\n$TLD${user.username}";
    }

    return csv;
  }

  void deleteUser(UserData user) {
    userList.remove(user);
    notifyListeners();
  }

  Future<void> syncDatabase() async {
    await UserDatabase.putAll(userList);
  }
}
