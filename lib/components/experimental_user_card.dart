import 'package:flutter/material.dart';
import '../pages/user.dart';
import 'dataclass/user_class/userdata.dart';
import 'image/circular_network.dart';

class ExperimentalUserCard extends StatelessWidget {
  const ExperimentalUserCard({super.key, required this.userData});
  final UserData userData;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.amber,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserPage(
                userData: userData,
              ),
            ),
          );
        },
        child: ListTile(
          leading: CircularNetworkImage(imageLink: userData.avatar),
          title: Text(userData.nickname),
          subtitle: Text(userData.username),
        ),
      ),
    );
  }
}
