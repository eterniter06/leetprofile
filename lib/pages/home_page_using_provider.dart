import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/components/database/settings_database.dart';
import 'package:ui_elements/components/database/user_database.dart';
import 'package:ui_elements/components/experimental_user_card.dart';
import 'package:ui_elements/components/theme.dart';
import 'package:ui_elements/pages/settings.dart';
import 'package:ui_elements/pages/user_details.dart';
import 'package:ui_elements/pages/user_list_provider.dart';

import '../components/dataclass/http_wrapper/data_parser.dart';
import '../components/dataclass/user_class/userdata.dart';
import '../components/dialog/user_input.dart';
import 'about.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeModel>(
      builder: (context, themeModeModel, child) => MaterialApp(
        theme: ThemeModeModel.light,
        darkTheme: ThemeModeModel.dark,
        themeMode: themeModeModel.themeMode,
        home: Consumer<UserListModel>(
          builder: (context, userListModel, child) =>
              UserListPageExperimental(userListModel: userListModel),
        ),
      ),
    );
  }
}

enum HomePopupMenuValue { about, settings }

class UserListPageExperimental extends StatefulWidget {
  const UserListPageExperimental({
    super.key,
    required this.userListModel,
  });

  final UserListModel userListModel;

  @override
  State<UserListPageExperimental> createState() =>
      _UserListPageExperimentalState();
}

class _UserListPageExperimentalState extends State<UserListPageExperimental> {
  @override
  initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    await widget.userListModel.loadUsers();
    if (SettingsDatabase.refreshAllUsersOnStartup()) {
      _updateUsers();
    }
  }

  Future<void> _updateUsers() async {
    await widget.userListModel.updateUsers();
    String snackbarMessage = widget.userListModel.isEmpty()
        ? 'Nothing to refresh'
        : 'All user profiles have been refreshed';

    _informUser(Text(snackbarMessage));
  }

  Future<UserData?> _createUser(String username) async {
    Map? data = await DataParser(username: username).getAllAsJson();
    return data == null ? null : UserData.fromMap(dataMap: data);
  }

  void _informUser(Widget content, [SnackBarAction? action]) {
    setState(() {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.amber,
          content: content,
          action: action,
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
          String? usernameInput = await showDialog(
            context: context,
            builder: (context) => const UserInputDialog(),
          );

          if (usernameInput == null) return;

          String username = usernameInput.trim();

          if (username.contains('leetcode.com/')) {
            String domainNameWithSlash = 'leetcode.com/';
            int usernameStart = username.indexOf(domainNameWithSlash) +
                domainNameWithSlash.length;
            int? usernameEnd = username.indexOf('/', usernameStart);

            if (usernameEnd < usernameStart) {
              usernameEnd = null;
            }

            username = username.substring(usernameStart, usernameEnd);
          }

          int index = widget.userListModel.indexOfUsername(username);

          if (index == -1) {
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
                widget.userListModel.addUser(user);
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
              SnackBarAction(
                label: 'Visit?',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserPage(
                          userData: widget.userListModel
                              .userFromUsername(username)!)));
                },
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('LeetProfile'),
        actions: [
          const IconButton(
            tooltip: "Today's daily question",
            icon: Icon(Icons.local_fire_department_sharp),
            onPressed: null,
          ),
          IconButton(
            tooltip: "Refresh all users",
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              _updateUsers();
            },
          ),
          PopupMenuButton(
            onSelected: (value) {
              Widget? page;
              switch (value) {
                case HomePopupMenuValue.settings:
                  page = const Settings();
                  break;
                case HomePopupMenuValue.about:
                  page = const About();
                  break;
              }
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => page!));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: HomePopupMenuValue.settings,
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: HomePopupMenuValue.about,
                child: Text('About'),
              ),
            ],
          ),
        ],
      ),
      body: ReorderableListView(
        proxyDecorator: (child, index, animation) => ExperimentalUserCard(
          userData: widget.userListModel.userAtIndex(index),
        ),
        onReorderStart: (index) => HapticFeedback.lightImpact(),
        onReorder: (oldIndex, newIndex) async {
          setState(() {
            // These two lines are workarounds for ReorderableListView problems
            // Source: https://stackoverflow.com/questions/54162721/onreorder-arguments-in-flutter-reorderablelistview?newreg=398dc3a491ee40fbad1b76ab1e303977
            if (newIndex > widget.userListModel.length()) {
              newIndex = widget.userListModel.length();
            }
            if (oldIndex < newIndex) newIndex--;
            UserData user = widget.userListModel.userAtIndex(oldIndex);
            widget.userListModel.deleteUser(user);
            widget.userListModel.insertUser(newIndex, user);
          });
          widget.userListModel.refreshListOrder();
          await widget.userListModel.syncDatabase();
        },
        children: [
          for (int index = 0; index < widget.userListModel.length(); ++index)
            OpenContainer(
              key: UniqueKey(),
              openBuilder: (context, action) => UserPage(
                userData: widget.userListModel.userAtIndex(index),
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
        UserDatabase.delete(widget.userListModel.userAtIndex(index));
        setState(() {
          UserData removedUser = widget.userListModel.deleteUserAt(index);
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
                      widget.userListModel.insertUser(index, removedUser);
                    });
                  },
                ),
              ),
            );
          }
        });
        widget.userListModel.refreshListOrder();
        widget.userListModel.syncDatabase();
      },
      key: Key(widget.userListModel.userAtIndex(index).username),
      child: genCard(index),
    );
  }

  dynamic genCard(int index) {
    var user = widget.userListModel.userAtIndex(index);
    user.listOrder = index;
    UserDatabase.put(user);
    return ExperimentalUserCard(userData: user);
  }
}
