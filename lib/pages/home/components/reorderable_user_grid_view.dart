import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:ui_elements/common_components/widgets/refresh_icon_button.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/home/components/user_grid_card.dart';
import 'package:ui_elements/pages/profile/profile.dart';
import 'package:ui_elements/providers/user_list.dart';

class ReorderableUserGridView extends StatelessWidget {
  const ReorderableUserGridView({
    super.key,
    this.refreshIconKey,
  });

  final GlobalKey<RefreshIconButtonState>? refreshIconKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserListModel>(
      builder: (context, userList, child) => ReorderableGridView.builder(
        onReorder: (oldIndex, newIndex) async {
          // setState(() {
          // These two lines are workarounds for ReorderableListView problems
          // Source: https://stackoverflow.com/questions/54162721/onreorder-arguments-in-flutter-reorderablelistview?newreg=398dc3a491ee40fbad1b76ab1e303977
          if (newIndex > userList.length()) {
            newIndex = userList.length();
          }
          if (oldIndex < newIndex) newIndex--;
          UserData user = userList.userAtIndex(oldIndex);
          // Remove from the application list
          userList.deleteUser(user);
          userList.insertUser(newIndex, user);
          // });
          userList.refreshListOrder();
          await userList.syncDatabase();
        },
        //TODO: figure out a count using usable device width and card width
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: userList.length(),
        itemBuilder: (context, index) => Card(
          key: Key(userList.userAtIndex(index).username),
          child: OpenContainer(
            openBuilder: (context, action) => ProfilePage(
              refreshIconKey: refreshIconKey,
              userData: userList.userAtIndex(index),
            ),
            closedColor: Theme.of(context).cardColor,
            closedBuilder: (context, action) =>
                UserGridCard(user: userList.userAtIndex(index)),
          ),
        ),
      ),
    );
  }
}
