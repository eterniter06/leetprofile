import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:ui_elements/components/database/database.dart';

import '../components/dataclass/http_wrapper/data_parser.dart';
import '../components/dataclass/user_class/userdata.dart';
import '../components/user_card.dart';
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
      debugShowCheckedModeBanner: false,
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
  }

  Future<UserData?> _createUser(String username) async {
    Map? data = await DataParser(username: username).getAllAsJson();
    return data == null ? null : UserData.fromMap(dataMap: data);
  }

  Future<void> _addToList(UserData user, [int? index]) async {
    await Database.put(user);

    setState(() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      userList.insert(index ?? userList.length, user);
    });
  }

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
              _addToList(user);
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
        actions: const [
          IconButton(
            tooltip: "Today's daily question",
            icon: Icon(Icons.local_fire_department_sharp),
            onPressed: null,
          ),
        ],
      ),
      body: ReorderableListView(
        // proxyDecorator: (child, index, animation) => UserCard(
        //   userData: userList[index],
        //   elevation: 3,
        //   color: Color.lerp(Colors.white, Colors.black, 0.08),
        // ),
        onReorder: (oldIndex, newIndex) async {
          setState(() {
            newIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
            UserData user = userList.removeAt(oldIndex);
            _addToList(user, newIndex);
          });
          refreshListOrder();
          await Database.putAll(userList);
        },
        // ReorderableListView.builder does not work, indexing issues
        // Preferably create a custom listview that is reorderable and has animations
        // itemCount: userList.length,
        // itemBuilder: (context, index) => Dismissible(
        // background: Container(color: Colors.redAccent),
        // onDismissed: (direction) async {
        //   var isar = await Database.isar();
        //   await isar!.writeTxn(() async {
        //     await isar.userDatas.delete(userList[index].isarId);
        //   });
        //   setState(() {
        //     userList.removeAt(index);
        //   });
        //   refreshListOrder();
        //   await isar.writeTxn(() => isar.userDatas.putAll(userList));
        // },
        // key: UniqueKey(),
        // child: genCard(userList, index),
        // ),
        children: [
          for (int index = 0; index < userList.length; ++index)
            Dismissible(
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
                            _addToList(removedUser, index);
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
            ),
        ],
      ),
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
    return UserCard(userData: userList[index]);
  }

  bool isNotInList(String username) {
    var index = userList.indexWhere((user) {
      return user.username == username;
    });
    return index == -1;
  }
}
