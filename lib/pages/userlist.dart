import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:ui_elements/components/database/database.dart';
import 'package:ui_elements/components/experimental_user_card.dart';
import 'package:ui_elements/pages/user.dart';

import '../components/dataclass/http_wrapper/data_parser.dart';
import '../components/dataclass/user_class/userdata.dart';
import '../components/dialog/user_input.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Overpass',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Overpass',
      ),
      themeMode: ThemeMode.system,
      home: const UserListPage(),
    );
  }
}

class UserListPage extends StatefulWidget {
  const UserListPage({
    super.key,
  });

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UserData> userList = [];

  @override
  initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    var isar = await Database.isar();
    var tempUserList = await isar!.userDatas
        .filter()
        .isarIdGreaterThan(Isar.minId)
        .sortByListOrder()
        .findAll();

    setState(() {
      userList = tempUserList;
    });

    await _updateUsers();
  }

  Future<void> _updateUser(UserData user) async {
    var dataMap = await DataParser(username: user.username).getAllAsJson();
    user.update(updatedUser: UserData.fromMap(dataMap: dataMap!));
  }

  Future<void> _updateUsers() async {
    List<Future> futureJsonList = [];
    for (var user in userList) {
      futureJsonList.add(DataParser(username: user.username).getAllAsJson());
    }

    var jsonList = await Future.wait(futureJsonList);

    setState(() {
      for (int i = 0; i < userList.length; ++i) {
        userList[i].update(updatedUser: UserData.fromMap(dataMap: jsonList[i]));
      }
    });

    _informUser(const Text('All user profiles have been refreshed'));
  }

  Future<UserData?> _createUser(String username) async {
    Map? data = await DataParser(username: username).getAllAsJson();
    return data == null ? null : UserData.fromMap(dataMap: data);
  }

  // Future<void> _addToList(UserData user, [int? index]) async {
  //   await Database.put(user);

  //   setState(() {
  //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //     userList.insert(index ?? userList.length, user);
  //   });
  // }

  void _informUser(Widget content) {
    setState(() {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.amber,
          content: content,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new User',
        onPressed: () async {
          String? username = await showDialog(
            context: context,
            builder: (context) {
              return const UserInputDialog();
            },
          );

          if (username == null) return;
          username = username.trim();

          if (isNotInList(username.toLowerCase())) {
            var user = await _createUser(username.toLowerCase());

            if (user == null) {
              _informUser(
                RichText(
                  text: TextSpan(
                    text: 'Username ',
                    children: [
                      TextSpan(
                        text: username,
                        style: const TextStyle(color: Colors.amber),
                      ),
                      const TextSpan(
                          text:
                              ' does not exist. Are you sure you typed in the correct username?'),
                    ],
                  ),
                ),
              );
            } else {
              setState(() {
                userList.add(user);
              });
            }
          } else if (mounted) {
            _informUser(
              RichText(
                text: TextSpan(
                  text: username,
                  style: const TextStyle(color: Colors.amber),
                  children: const [
                    TextSpan(
                      text: ' is already in list.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('LeetProfile'),
        actions: [
          IconButton(
            tooltip: "Refresh all users",
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              _updateUsers();
            },
          ),
          const IconButton(
            tooltip: "Today's daily question",
            icon: Icon(Icons.local_fire_department_sharp),
            onPressed: null,
          ),
        ],
      ),
      body: ReorderableListView(
        proxyDecorator: (child, index, animation) => ExperimentalUserCard(
          userData: userList[index],
        ),
        onReorder: (oldIndex, newIndex) async {
          setState(() {
            // These two lines are workarounds for ReorderableListView problems
            // Source: https://stackoverflow.com/questions/54162721/onreorder-arguments-in-flutter-reorderablelistview?newreg=398dc3a491ee40fbad1b76ab1e303977
            if (newIndex > userList.length) newIndex = userList.length;
            if (oldIndex < newIndex) newIndex--;

            UserData user = userList[oldIndex];
            userList.remove(user);
            userList.insert(newIndex, user);
          });
          refreshListOrder();
          await Database.putAll(userList);
        },
        children: [
          for (int index = 0; index < userList.length; ++index)
            OpenContainer(
              key: UniqueKey(),
              openBuilder: (context, action) => UserPage(
                userData: userList[index],
              ),
              closedBuilder: (context, action) =>
                  dismissableCard(index, context),
            ),
        ],
      ),
    );
  }

  Dismissible dismissableCard(int index, BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.redAccent),
      onDismissed: (direction) async {
        Database.delete(userList[index]);
        setState(() {
          UserData removedUser = userList.removeAt(index);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 6),
                showCloseIcon: true,
                closeIconColor: Colors.amber,
                content: RichText(
                  softWrap: true,
                  text: TextSpan(
                    text: 'User ',
                    children: [
                      TextSpan(
                        text: removedUser.nickname,
                        style: const TextStyle(color: Colors.amber),
                      ),
                      const TextSpan(text: ' removed'),
                    ],
                  ),
                ),
                action: SnackBarAction(
                  disabledTextColor: Colors.white,
                  label: 'Undo?',
                  textColor: Colors.amberAccent,
                  onPressed: () {
                    setState(() {
                      userList.insert(index, removedUser);
                    });
                  },
                ),
              ),
            );
          }
        });
        refreshListOrder();
        Database.putAll(userList);
      },
      key: Key(userList[index].username),
      child: genCard(userList, index),
    );
  }

  void refreshListOrder() {
    for (int i = 0; i < userList.length; ++i) {
      userList[i].listOrder = i;
    }
  }

  dynamic genCard(List<UserData> userList, int index) {
    userList[index].listOrder = index;
    Database.put(userList[index]);
    return ExperimentalUserCard(userData: userList[index]);
  }

  bool isNotInList(String username) {
    var index = userList.indexWhere((user) {
      return user.username == username;
    });
    return index == -1;
  }
}