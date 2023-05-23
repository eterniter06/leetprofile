import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ui_elements/pages/user_details.dart';

import 'change_notifiers/user_list.dart';
import 'dataclass/user_class/userdata.dart';
import 'dismissible_list_tile.dart';
import 'user_list_tile.dart';

class ReorderableUserListView extends StatelessWidget {
  const ReorderableUserListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserListModel>(
      builder: (context, userListModel, child) => ReorderableListView(
        proxyDecorator: (child, index, animation) => ExperimentalUserCard(
          userData: userListModel.userAtIndex(index),
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
          for (int index = 0; index < userListModel.length(); ++index)
            OpenContainer(
              key: UniqueKey(),
              openBuilder: (context, action) => UserPage(
                userData: userListModel.userAtIndex(index),
              ),
              closedBuilder: (context, action) => DismissibleListTile(
                userData: userListModel.userAtIndex(index),
              ),
            ),
        ],
      ),
    );
  }
}
