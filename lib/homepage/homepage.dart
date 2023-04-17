import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/data_parser.dart';
import 'package:ui_elements/homepage/usercard.dart';
import '../dataclass/user_class/userdata.dart';
import '../userpage/userview.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Overpass'),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<UserData?> createUser(String username) async {
  Map? data = await DataParser(username: username).getAllAsJson();
  return data == null ? null : UserData.fromMap(dataMap: data);
}

class _HomePageState extends State<HomePage> {
  List<Widget> userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Title'),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_fire_department_sharp),
            onPressed: () => 0,
          ),
          IconButton(
            tooltip: 'Add new User',
            icon: const Icon(Icons.add),
            onPressed: () async {
              String? username = await showDialog(
                context: context,
                builder: (context) {
                  return const UserInputDialog();
                },
              );

              if (username == null) {
                return;
              }

              var user = await createUser(username);

              if (user != null) {
                setState(() {
                  userList.add(UserCard(userData: user));
                });
              } else {
                setState(() {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      showCloseIcon: true,
                      content: Text('Username "$username" does not exist.'),
                    ),
                  );
                });
              }
            },
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) => userList[index],
        ),
      ),
    );
  }
}

class UserInputDialog extends StatefulWidget {
  const UserInputDialog({
    super.key,
  });

  @override
  State<UserInputDialog> createState() => _UserInputDialogState();
}

class _UserInputDialogState extends State<UserInputDialog> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void submitUserInput() {
    setState(() {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          showCloseIcon: true,
          content: Text('Searching user: ${_textController.text}')),
    );

    Navigator.pop(context, _textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      key: _formKey,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: SizedBox(
            height: 64,
            width: 64,
            child: Image.asset(
              'assets/leetcode_logo.png',
              semanticLabel: 'Leetcode logo',
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(26.0, 8.0, 26.0, 4.0),
          child: Text(
            'Enter username of the profile to search',
            softWrap: true,
            textWidthBasis: TextWidthBasis.parent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
          child: TextFormField(
            autofocus: true,
            controller: _textController,
            onFieldSubmitted: (value) => submitUserInput(),
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              label: Text('Leetcode Username'),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 8),
            ),
            enableSuggestions: true,
          ),
        ),
        SizedBox(
          child: TextButton(
            onPressed: () => submitUserInput(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Search'),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedCard extends StatelessWidget {
  final UserData userData;
  const AnimatedCard({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) {
        return UserCard(userData: userData);
      },
      openBuilder: (context, action) {
        return UserView(userData: userData);
      },
    );
  }
}
