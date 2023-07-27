import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ui_elements/change_notifiers/user_list.dart';
import 'package:ui_elements/database/user_database.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/home/components/dismissible_background.dart';

import 'user_list_tile.dart';

class DismissibleListTile extends StatelessWidget {
  const DismissibleListTile({
    super.key,
    required this.userData,
  });

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    bool removed = false;

    // TODO: Adjust sensitivity of drag
    // TODO: Determine if this is a good location for the removed variable
    return Consumer<UserListModel>(
      builder: (context, userListModel, child) => Dismissible(
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
          userListModel.deleteUser(userData);
          removed = true;
          int index = userData.listOrder!;
          if (context.mounted) {
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
                        text: userData.nickname,
                      ),
                      const TextSpan(text: ' removed'),
                    ],
                  ),
                ),
                action: SnackBarAction(
                  label: 'Undo?',
                  onPressed: () {
                    userListModel.insertUser(index, userData);
                    removed = false;
                  },
                ),
              ),
            );
          }
          if (removed) {
            UserDatabase.delete(userData);
            userListModel.refreshListOrder();
            await userListModel.syncDatabase();
          }
        },
        key: UniqueKey(),
        child: UserCard(userData: userData),
      ),
    );
  }
}
