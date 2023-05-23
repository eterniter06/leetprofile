import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ui_elements/components/database/settings_database.dart';
import 'package:ui_elements/components/database/user_database.dart';
import 'package:ui_elements/components/dialog/user_input.dart';
import 'package:ui_elements/components/change_notifiers/theme.dart';
import 'package:ui_elements/pages/settings.dart';
import 'package:ui_elements/pages/user_details.dart';
import 'package:ui_elements/components/change_notifiers/user_list.dart';
import 'about.dart';
import '../components/reorderable_listview.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserListModel(),
      child: MaterialApp(
        theme: ThemeModeModel.light,
        darkTheme: ThemeModeModel.dark,
        themeMode: Provider.of<ThemeModeModel>(context).themeMode,
        home: Consumer<UserListModel>(
          builder: (context, userListModel, child) =>
              UserListPage(userListModel: userListModel),
        ),
        // home: const UserListPage(),
      ),
    );
  }
}

enum HomePopupMenuValue { about, settings }

class UserListPage extends StatefulWidget {
  const UserListPage({
    super.key,
    required this.userListModel,
  });

  final UserListModel userListModel;

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    await widget.userListModel.loadUsersFromDatabase();
    if (SettingsDatabase.refreshAllUsersOnStartup()) {
      _updateUsers();
    }
  }

  Future<void> _updateUsers() async {
    await widget.userListModel.updateUsersFromServer();
    if (!widget.userListModel.isEmpty()) {
      _informUser(const Text('All user profiles have been refreshed'));
    }
  }

  void _informUser(Widget content, [SnackBarAction? action]) {
    setState(() {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
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

          String username = _processInputtedUsername(usernameInput);

          if (!widget.userListModel.contains(username)) {
            var user = await UserListModel.createUserFromUsername(
                username.toLowerCase());

            if (user == null) {
              _informUser(
                Text(
                    'Username $username does not exist. Are you sure you typed in the correct username?'),
              );
            } else {
              user.listOrder = widget.userListModel.length();
              UserDatabase.put(user);
              setState(() {
                widget.userListModel.addUser(user);
              });
            }
          } else if (mounted) {
            _informUser(
              Text('$username is already in list'),
              SnackBarAction(
                label: 'Visit?',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserPage(
                          userData: widget.userListModel
                              .findUserFromUsername(username)!)));
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
            icon: Icon(Icons.local_fire_department_rounded),
            onPressed: null,
          ),
          IconButton(
            tooltip: "Refresh all users",
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              _updateUsers();
              if (widget.userListModel.isEmpty()) {
                _informUser(
                    const Text('Nothing to refersh. Add some profiles first'));
              }
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
      body: const ReorderableUserListView(),
    );
  }

  String _processInputtedUsername(String usernameInput) {
    String username = usernameInput.trim();

    if (username.contains('leetcode.com/')) {
      String domainNameWithSlash = 'leetcode.com/';
      int usernameStart =
          username.indexOf(domainNameWithSlash) + domainNameWithSlash.length;
      int? usernameEnd = username.indexOf('/', usernameStart);

      if (usernameEnd < usernameStart) {
        usernameEnd = null;
      }

      username = username.substring(usernameStart, usernameEnd);
    }
    return username;
  }
}
