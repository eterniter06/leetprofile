import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/database/user_database.dart';
import 'package:ui_elements/pages/home/components/dismissible_background.dart';
import 'package:ui_elements/providers/user_list.dart';
import 'package:ui_elements/pages/profile/user_view.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'package:ui_elements/common_components/widgets/refresh_icon_button.dart';

import 'user_list_tile.dart';

class ReorderableUserListView extends StatefulWidget {
  final GlobalKey<RefreshIconButtonState>? refreshIconKey;
  const ReorderableUserListView({
    super.key,
    this.refreshIconKey,
  });

  @override
  State<ReorderableUserListView> createState() =>
      _ReorderableUserListViewState();
}

class _ReorderableUserListViewState extends State<ReorderableUserListView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      upperBound: 1.025,
      lowerBound: 1,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserListModel>(
      builder: (context, userListModel, child) => ReorderableListView(
        proxyDecorator: (child, index, animation) => ScaleTransition(
          scale: Tween<double>(begin: 1, end: 1.025).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.linear,
            ),
          ),
          child: UserCard(
            userData: userListModel.userAtIndex(index),
          ),
        ),
        onReorderStart: (index) => HapticFeedback.lightImpact(),
        onReorder: (oldIndex, newIndex) async {
          // setState(() {
          // These two lines are workarounds for ReorderableListView problems
          // Source: https://stackoverflow.com/questions/54162721/onreorder-arguments-in-flutter-reorderablelistview?newreg=398dc3a491ee40fbad1b76ab1e303977
          if (newIndex > userListModel.length()) {
            newIndex = userListModel.length();
          }
          if (oldIndex < newIndex) newIndex--;
          UserData user = userListModel.userAtIndex(oldIndex);
          // Remove from the application list
          userListModel.deleteUser(user);
          userListModel.insertUser(newIndex, user);
          // });
          userListModel.refreshListOrder();
          await userListModel.syncDatabase();
        },
        children: [
          for (int loopIndex = 0;
              loopIndex < userListModel.length();
              ++loopIndex)
            Dismissible(
              key: UniqueKey(),
              background: const DismissableBackground(
                alignment: AlignmentDirectional.centerStart,
              ),
              secondaryBackground: const DismissableBackground(
                alignment: AlignmentDirectional.centerEnd,
              ),
              dismissThresholds: const {DismissDirection.horizontal: 0.45},
              onUpdate: (details) {
                if (!details.previousReached && details.reached) {
                  HapticFeedback.lightImpact();
                }
              },
              confirmDismiss: (DismissDirection direction) async {
                UserData userData = userListModel.userAtIndex(loopIndex);
                bool removed = true;

                if (context.mounted) {
                  SnackBar undoDeleteSnack = SnackBar(
                    duration: const Duration(seconds: 6),
                    content: Text.rich(
                      TextSpan(
                        text: 'User ',
                        children: [
                          TextSpan(
                            text: userData.nickname ?? userData.username,
                          ),
                          const TextSpan(text: ' removed from list'),
                        ],
                      ),
                    ),
                    action: SnackBarAction(
                      label: 'Undo?',
                      onPressed: () {
                        removed = false;
                      },
                    ),
                  );

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
                      sfc = ScaffoldMessenger.of(context)
                          .showSnackBar(undoDeleteSnack);

                  await sfc.closed;
                }
                return removed;
              },
              onDismissed: (direction) async {
                UserDatabase.delete(userListModel.userAtIndex(loopIndex));
                userListModel.deleteUserAt(loopIndex);
                userListModel.refreshListOrder();
                await userListModel.syncDatabase();
              },
              child: OpenContainer(
                tappable: false,
                openBuilder: (context, action) => UserView(
                  refreshIconKey: widget.refreshIconKey,
                  userData: userListModel.userAtIndex(loopIndex),
                ),
                openColor:
                    MediaQuery.platformBrightnessOf(context) == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                closedBuilder: (context, action) => UserCard(
                  userData: userListModel.userAtIndex(loopIndex),
                  openView: action,
                ),
                closedColor:
                    MediaQuery.platformBrightnessOf(context) == Brightness.dark
                        ? Colors.black
                        : Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
