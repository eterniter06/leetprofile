import 'package:flutter/material.dart';
import '../dataclass/user_class/userdata.dart';
import '../userpage/userview.dart';

class UserCard extends StatefulWidget {
  final UserData userData;

  const UserCard({super.key, required this.userData});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  UserData? currentUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 2.0),
      child: InkWell(
        onTap: () async {
          var user = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    UserView(userData: (currentUser ?? widget.userData))),
          );

          setState(() {
            currentUser = user;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SquircleNetworkImage(
                  imageLink: (currentUser ?? widget.userData).avatar ?? ''),
              const SizedBox(
                height: 0.0,
                width: 12.0,
              ),
              Text(
                (currentUser ?? widget.userData).nickname,
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 24.0,
                  fontFamily: 'Overpass',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SquircleNetworkImage extends StatelessWidget {
  const SquircleNetworkImage({super.key, required this.imageLink});

  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), //or 15.0
      child: SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.network(
          imageLink,
          fit: BoxFit.cover,
          semanticLabel: 'Profile picture',
          // ),
        ),
      ),
    );
  }
}
