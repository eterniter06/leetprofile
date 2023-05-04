import 'package:flutter/material.dart';
import 'dataclass/user_class/userdata.dart';
import '../pages/user.dart';
import 'image/squircle_network.dart';

class UserCard extends StatelessWidget {
  final UserData userData;
  final Color? color;
  final double elevation;
  const UserCard(
      {super.key, required this.userData, this.color, this.elevation = 1.0});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      margin: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 2.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserPage(
                userData: userData,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SquircleNetworkImage(imageLink: userData.avatar),
              const SizedBox(
                height: 0.0,
                width: 12.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData.nickname,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 24.0,
                      fontFamily: 'Overpass',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  Text(userData.username),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
