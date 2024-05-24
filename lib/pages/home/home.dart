import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/common_components/widgets/profile_import_progress_indicator.dart';
import 'package:ui_elements/pages/home/components/reorderable_user_grid_view.dart';
import 'package:ui_elements/pages/profile/profile.dart';

import 'package:ui_elements/database/settings_database.dart';
import 'package:ui_elements/database/user_database.dart';
import 'package:ui_elements/providers/profile_importing.dart';

import 'package:ui_elements/providers/user_list.dart';
import 'package:ui_elements/providers/settings.dart';

import 'package:ui_elements/pages/about/about.dart';
import 'package:ui_elements/pages/settings/settings.dart';
import 'package:ui_elements/common_components/widgets/refresh_icon_button.dart';
import 'package:ui_elements/common_components/ui_vars.dart';
import 'package:uni_links/uni_links.dart';

import 'components/input_dialog.dart';
import 'components/reorderable_listview.dart';

//TODO: Replace uni_links with app_links: https://pub.dev/packages/app_links

enum HomePopupMenuValue { about, settings }

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.userListModel,
  });

  final UserListModel userListModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

bool _initialUriIsHandled = false;

class _HomePageState extends State<HomePage> {
  late final AnimationController _controller;
  late final Widget refreshIcon;
  final refreshKey = GlobalKey<RefreshIconButtonState>();

  StreamSubscription? _sub;

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
    _handleIncomingLinks();
    _handleInitialUri();
  }

  @override
  void dispose() {
    _controller.dispose();
    _sub?.cancel();
    super.dispose();
  }

  void _handleIncomingLinks() {
    // It will handle app links while the app is already started - be it in
    // the foreground or in the background.
    _sub = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      addUser(userLink: uri.toString());
    }, onError: (Object err) {
      if (!mounted) return;
    });
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final link = await getInitialLink();
        if (link != null) {
          addUser(userLink: link);
        }
        if (!mounted) return;
      } on FormatException catch (_) {
        if (!mounted) return;
      }
    }
  }

  Future<void> _loadUsers() async {
    await widget.userListModel.loadUsersFromDatabase();
    final bool refreshOnStartup = SettingsDatabase.refreshAllUsersOnStartup();

    if (refreshOnStartup && widget.userListModel.isNotEmpty()) {
      refreshKey.currentState!.onPress();
    }
  }

  void _informUser(Widget content, [SnackBarAction? action]) {
    setState(() {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: content,
          action: action,
        ),
      );
    });
  }

  Future<void> addUser({String? userLink}) async {
    String? usernameInput = userLink ??
        await showDialog(
          context: context,
          builder: (context) => const UserInputDialog(),
        );

    // TODO: Preferably use a class for the following:
    if (usernameInput == null) return;

    String username = _processInputtedUsername(usernameInput);

    if (!widget.userListModel.contains(username)) {
      var user =
          await UserListModel.createUserFromUsername(username.toLowerCase());

      if (user == null) {
        _informUser(
          Text(
              'Username $username does not exist. Are you sure you typed in the correct username?'),
        );
      } else {
        user.listOrder = widget.userListModel.length();
        UserDatabase.put(user);
        widget.userListModel.addUser(user);
      }
    } else if (mounted) {
      if (userLink != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProfilePage(
                userData: widget.userListModel.findUserFromUsername(username)!),
          ),
        );
      } else {
        _informUser(
          Text('$username is already in list'),
          SnackBarAction(
            label: 'Visit?',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                      userData:
                          widget.userListModel.findUserFromUsername(username)!),
                ),
              );
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<SettingsModel>();
    return Scaffold(
      key: RootScaffoldKey().scaffoldkey,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new User',
        onPressed: () => addUser(),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('LeetProfile'),
        bottom: Provider.of<ProfileImportStatus>(context).isProfileBeingImported
            ? const ProfileImportProgressIndicator()
            : null,
        actions: [
          //TODO: implement
          // const IconButton(
          //   tooltip: "Today's daily question",
          //   icon: Icon(Icons.local_fire_department_rounded),
          //   onPressed: null,
          // ),
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
      body: widget.userListModel.isEmpty()
          ? LayoutBuilder(
              builder: (context, constraints) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height:
                        (constraints.maxHeight - constraints.minHeight) * 0.2,
                  ),
                  SvgPicture.asset(
                    'assets/add_friends_yellow.svg',
                    height: 200,
                  ),
                  const Center(child: Text('No users yet')),
                  const Center(child: Text('Click on + to add profiles'))
                ],
              ),
            )
          : OrientationBuilder(
              builder: (context, orientation) => orientation ==
                      Orientation.portrait
                  ? ReorderableUserListView(
                      refreshIconKey: refreshKey,
                    )
                  //TODO: Try a custom grid implementation
                  : Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child:
                          ReorderableUserGridView(refreshIconKey: refreshKey),
                    ),
            ),
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
