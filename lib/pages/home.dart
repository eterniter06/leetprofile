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
import '../components/dataclass/user_class/userdata.dart';
import '../components/dialog/user_input.dart';
import '../components/dismissible_background.dart';
import 'about.dart';

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
              UserListPageExperimental(userListModel: userListModel),
        ),
        // home: const UserListPage(),
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
          int index = widget.userListModel.indexOfUsername(username);

          if (_isNotInList(index)) {
            var user = await UserListModel.createUserFromUsername(
                username.toLowerCase());

            if (user == null) {
              _informUser(
                RichText(
                  text: TextSpan(
                    text: 'Username ',
                    children: [
                      TextSpan(
                        text: username,
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
                  children: const [
                    TextSpan(
                      text: ' is already in list.',
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
      body: ReorderableListView(
        proxyDecorator: (child, index, animation) => ExperimentalUserCard(
          userData: widget.userListModel.userAtIndex(index),
        ),
        onReorderStart: (index) => HapticFeedback.lightImpact(),
        onReorder: (oldIndex, newIndex) async {
          // setState(() {
          // These two lines are workarounds for ReorderableListView problems
          // Source: https://stackoverflow.com/questions/54162721/onreorder-arguments-in-flutter-reorderablelistview?newreg=398dc3a491ee40fbad1b76ab1e303977
          if (newIndex > widget.userListModel.length()) {
            newIndex = widget.userListModel.length();
          }
          if (oldIndex < newIndex) newIndex--;
          UserData user = widget.userListModel.userAtIndex(oldIndex);
          // Remove from the application list
          widget.userListModel.deleteUser(user);
          widget.userListModel.insertUser(newIndex, user);
          // });
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
                  dismissibleCard(index, context),
            ),
        ],
      ),
    );
  }

  bool _isNotInList(int index) => index == -1;

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

  /// Multiple concurrent dismisses don't work for reasons undiscovered
  Dismissible dismissibleCard(int index, BuildContext context) {
    return Dismissible(
      background: const DismissableBackground(
        alignment: AlignmentDirectional.centerStart,
      ),
      secondaryBackground: const DismissableBackground(
        alignment: AlignmentDirectional.centerEnd,
      ),
      onUpdate: (details) {
        if (!details.previousReached && details.reached) {
          HapticFeedback.lightImpact();
        }
      },
      dismissThresholds: const {DismissDirection.horizontal: 0.45},
      onDismissed: (DismissDirection direction) async {
        UserData? removedUser = widget.userListModel.deleteUserAt(index);
        if (mounted) {
          // Cannot add both, flexibility to insert back at same index
          // and option to stack undo users due to indexing conflict
          // e.g. Delete user at index 5 in a list of size 6 and then delete 2 more users
          // Since list size is now smaller than initial index, exception is thrown
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 6),
              showCloseIcon: true,
              content: RichText(
                softWrap: true,
                text: TextSpan(
                  text: 'User ',
                  children: [
                    TextSpan(
                      text: removedUser.nickname,
                    ),
                    const TextSpan(text: ' removed'),
                  ],
                ),
              ),
              action: SnackBarAction(
                label: 'Undo?',
                onPressed: () {
                  widget.userListModel.insertUser(index, removedUser!);
                  removedUser = null;
                },
              ),
            ),
          );
        }
        if (removedUser != null) {
          UserDatabase.delete(removedUser!);
          widget.userListModel.refreshListOrder();
          await widget.userListModel.syncDatabase();
        }
      },
      key: UniqueKey(),
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
