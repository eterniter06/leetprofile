import 'package:flutter/material.dart';
import 'dataclass/user_class/userdata.dart';
import 'image/circular_network.dart';

class ExperimentalUserCard extends StatelessWidget {
  const ExperimentalUserCard({super.key, required this.userData});
  final UserData userData;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircularNetworkImage(imageLink: userData.avatar),
        title: Text(userData.nickname),
        subtitle: Text(userData.username),
      ),
    );
  }
}
