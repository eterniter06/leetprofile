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
              builder: (context) => UserView(
                userData: (currentUser ?? widget.userData),
              ),
            ),
          );

          setState(() {
            currentUser = user;
          });
        },
        onLongPress: () async {
          String? nickname = await showDialog(
            context: context,
            builder: (context) {
              return NicknameInputDialog(oldNickname: widget.userData.nickname);
            },
          );

          if (nickname == null) {
            return;
          }

          setState(() {
            widget.userData.nickname = nickname;
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

class NicknameInputDialog extends StatefulWidget {
  const NicknameInputDialog({
    super.key,
    required this.oldNickname,
  });

  final String oldNickname;

  @override
  State<NicknameInputDialog> createState() => _NicknameInputDialogState();
}

class _NicknameInputDialogState extends State<NicknameInputDialog> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void submitNickname() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            showCloseIcon: true,
            content: Text(
                'Nickname changed. ${widget.oldNickname} -> ${_textController.text}')),
      );

      Navigator.pop(context, _textController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(26.0, 8.0, 26.0, 4.0),
          child: Text(
            'Enter a new nickname for ${widget.oldNickname}:',
            softWrap: true,
            textWidthBasis: TextWidthBasis.parent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
          child: Form(
            key: _formKey,
            child: TextFormField(
              autofocus: true,
              controller: _textController,
              validator: (String? username) {
                if (username == null || username.isEmpty) {
                  return 'Nickname cannot be empty.';
                }
                return null;
              },
              onFieldSubmitted: (value) => submitNickname(),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                label: Text('User Nickname'),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 8),
              ),
              enableSuggestions: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
          child: ElevatedButton(
            onPressed: () => submitNickname(),
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
