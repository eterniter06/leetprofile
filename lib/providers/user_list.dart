import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:ui_elements/dataclass/http_wrapper/data_parser.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import '../database/user_database.dart';

enum ExportUsernameType {
  /// Export only the username without any link
  normal,

  /// Exports username in the old format, ie `https://leetcode.com/$username`
  asLegacyLink,

  /// exports the username in the current format: `https://leetcode.com/$username`
  asLink
}

class UserListModel extends ChangeNotifier {
  List<UserData> userList = [];

  bool _isInitialized = false;

  ///Assumes that the link is indeed a username link, i.e.
  ///the link is either of the following: `https://leetcode.com/u/$username` or
  ///`https://leetcode.com/$username`
  static String extractUsernameFromLink(String usernameInput) {
    usernameInput = usernameInput.trim();

    if (usernameInput.lastIndexOf('/') == usernameInput.length - 1) {
      usernameInput =
          usernameInput.substring(0, usernameInput.lastIndexOf('/'));
    }

    usernameInput = usernameInput.substring(usernameInput.lastIndexOf('/') + 1);
    return usernameInput;
  }

  int length() {
    return userList.length;
  }

  bool isEmpty() {
    return userList.isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }

  int indexOfUsername(String username) {
    return userList.indexWhere((userInList) {
      return userInList.username == username;
    });
  }

  bool contains(String username) {
    return indexOfUsername(username) != -1;
  }

  bool doesNotContain(String username) {
    return !contains(username);
  }

  UserData? findUserFromUsername(String username) {
    int index = indexOfUsername(username);
    return index == -1 ? null : userList[index];
  }

  UserData userAtIndex(int index) {
    if (index >= userList.length) {
      throw "Out of bounds. Index accessed: $index, length of list: ${userList.length}";
    }

    return userList[index];
  }

  void addUser(UserData user) {
    if (contains(user.username)) {
      return;
    }

    userList.add(user);
    notifyListeners();
  }

  void insertUser(int index, UserData user) {
    if (contains(user.username)) {
      return;
    }

    userList.insert(index, user);
    notifyListeners();
  }

  Future<void> loadUsersFromDatabase() async {
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

    // refreshListOrder(); //todo investigate if redundant
  }

  Future<void> updateUser(UserData user) async {
    var dataMap = await DataParser(username: user.username).getAllAsJson();
    user.update(updatedUser: UserData.fromMap(dataMap: dataMap!));

    notifyListeners();
  }

  Future<void> updateUsersFromServer() async {
    List<Future> futureJsonList = [];
    for (var user in userList) {
      futureJsonList.add(DataParser(username: user.username).getAllAsJson());
    }

    Queue<dynamic> jsonQueue = Queue.from(await Future.wait(futureJsonList));

    // Take care of reordering that occurs in between refreshing
    // Consider using mapping from Username to userData and index

    while (jsonQueue.isNotEmpty) {
      var first = jsonQueue.first;
      jsonQueue.removeFirst();

      var updatedUser = UserData.fromMap(dataMap: first);

      int index = indexOfUsername(updatedUser.username);
      // User was removed in between refreshing
      if (index == -1) {
        continue;
      }

      updatedUser.listOrder = index;
      userList[index].update(updatedUser: updatedUser);
    }

    notifyListeners();
  }

  static Future<UserData?> createUserFromUsername(String username) async {
    Map? data = await DataParser(username: username).getAllAsJson();
    return data == null ? null : UserData.fromMap(dataMap: data);
  }

  Future<void> addUserFromUsername(String username) async {
    UserData? user = await createUserFromUsername(username);
    if (user == null) {
      return;
    }

    addUser(user);
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

  String exportUsernamesAsCSV(
      {ExportUsernameType usernameType = ExportUsernameType.normal}) {
    String headerColumn = 'Username';

    String csv = headerColumn;
    String topLevelDomain = '';

    if (usernameType == ExportUsernameType.asLegacyLink) {
      topLevelDomain = 'https://leetcode.com/';
    } else if (usernameType == ExportUsernameType.asLink) {
      topLevelDomain = 'https://leetcode.com/u/';
    }

    for (var user in userList) {
      csv = "$csv\n$topLevelDomain${user.username}";
    }

    return csv;
  }

  void deleteUser(UserData user) {
    userList.remove(user);
    notifyListeners();
  }

  UserData deleteUserAt(int index) {
    if (index >= userList.length) {
      throw "Out of bounds. Index accessed: $index, length of list: ${userList.length}";
    }

    UserData deleted = userList.removeAt(index);
    notifyListeners();
    return deleted;
  }

  Future<void> deleteAllDatabaseSync() async {
    userList.clear();
    notifyListeners();
    await UserDatabase.deleteAll();
  }

  Future<void> syncDatabase() async {
    await UserDatabase.putAll(userList);
  }

  void importUsersFromList(List userList) {
    bool userAdded = false;

    for (UserData? user in userList) {
      if (user == null) {
        // ToDo: tell user username no longer exists
        continue;
      }

      if (contains(user.username)) {
        continue;
      }

      user.listOrder = length();
      addUser(user);
      userAdded = true;
    }

    if (userAdded) {
      notifyListeners();
    }
  }
}
