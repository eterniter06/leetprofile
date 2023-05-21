import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../components/database/user_database.dart';
import '../components/dataclass/http_wrapper/data_parser.dart';
import '../components/dataclass/user_class/userdata.dart';

class UserListModel extends ChangeNotifier {
  List<UserData> userList = [];

  bool _isInitialized = false;

  int length() {
    return userList.length;
  }

  bool isEmpty() {
    return userList.isEmpty;
  }

  int indexOfUsername(String username) {
    return userList.indexWhere((userInList) {
      return userInList.username == username;
    });
  }

  bool inList(String username) {
    return indexOfUsername(username) != -1;
  }

  UserData? userFromUsername(String username) {
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
    int index = userList.indexWhere((userInList) {
      return userInList.username == user.username;
    });

    if (index == -1) {
      userList.add(user);
      notifyListeners();
    }
  }

  void insertUser(int index, UserData user) {
    int existingIndex = userList.indexWhere((userInList) {
      return userInList.username == user.username;
    });

    if (existingIndex == -1) {
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

  String exportUsernamesAsCSV({bool withTLD = false}) {
    String headerColumn = 'Username';

    String csv = headerColumn;
    String topLevelDomain = withTLD ? 'https://leetcode.com/' : '';

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

  Future<void> syncDatabase() async {
    await UserDatabase.putAll(userList);
  }

  void importUsersFromList(List userList) {
    bool userAdded = false;
    for (var user in userList) {
      if (!inList(user.username)) {
        addUser(user);
        userAdded = true;
      }
    }

    if (userAdded) {
      notifyListeners();
    }
  }
}
