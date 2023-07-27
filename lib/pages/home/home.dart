import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ui_elements/database/settings_database.dart';
import 'package:ui_elements/database/user_database.dart';

import 'package:ui_elements/change_notifiers/theme.dart';
import 'package:ui_elements/change_notifiers/user_list.dart';

import 'package:ui_elements/pages/about/about.dart';
import 'package:ui_elements/pages/profile/profile.dart';
import 'package:ui_elements/pages/settings/settings.dart';
import 'package:ui_elements/refresh_icon_button.dart';

import 'components/input_dialog.dart';
import 'components/reorderable_listview.dart';

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
  late AnimationController _controller;
  late Widget refreshIcon;
  final refreshKey = GlobalKey<RefreshIconButtonState>();
  bool refreshOnStartup = false;

  @override
  initState() {
    super.initState();

    refreshIcon = RefreshIconButton(
      key: refreshKey,
      task: () async {
        await widget.userListModel.updateUsersFromServer();
      },
      postHook: () async {
        if (!widget.userListModel.isEmpty()) {
          _informUser(const Text('User profiles have been refreshed'));
        }

        await widget.userListModel.syncDatabase();
      },
      tooltip: 'Refresh all users',
    );

    _loadUsers();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    await widget.userListModel.loadUsersFromDatabase();
    refreshOnStartup = SettingsDatabase.refreshAllUsersOnStartup();
    refreshKey.currentState!.onPress();
    // TODO: Find a way to emulate button press
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

          // TODO: Preferably use a class for the following:
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
          refreshIcon,
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
      body: ReorderableUserListView(
        refreshIconKey: refreshKey,
      ),

      // Future feature
      // body: RefreshIndicator(
      //     onRefresh: _updateUsers, child: const ReorderableUserListView()),
    );
  }

  String _processInputtedUsername(String usernameInput) {
    String username = usernameInput.trim();
    String domainNameWithSlash = 'leetcode.com/';

    if (username.contains(domainNameWithSlash)) {
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
