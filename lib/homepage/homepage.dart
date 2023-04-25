import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:ui_elements/database.dart';
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
      debugShowCheckedModeBanner: false,
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

class _HomePageState extends State<HomePage> {
  List<UserData> userList = [];

  @override
  initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    var isar = await Database.isar();
    var tempUserList =
        await isar!.userDatas.filter().isarIdGreaterThan(Isar.minId).findAll();

    setState(() {
      for (var user in tempUserList) {
        userList.add(user);
      }
    });
  }

  Future<UserData?> createUser(String? username) async {
    if (username == null) return null;

    Map? data = await DataParser(username: username).getAllAsJson();
    return data == null ? null : UserData.fromMap(dataMap: data);
  }

  Future<void> addToList(UserData user) async {
    var database = await Database.isar();
    await database!.writeTxn(() async {
      await Database.database().then((db) => db!.put(user));
    });

    setState(() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      userList.add(user);
    });
  }

  void informUser(String info) {
    setState(() {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          content: Text(info),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new User',
        onPressed: () async {
          String? username = await showDialog(
            context: context,
            builder: (context) {
              return const UserInputDialog();
            },
          );

          var user = await createUser(username);

          if (user == null) {
            informUser(
                'Username "$username" does not exist. Are you sure you typed in the correct username?');
          } else {
            addToList(user);
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Home Title'),
        actions: [
          IconButton(
            tooltip: "Today's daily question",
            icon: const Icon(Icons.local_fire_department_sharp),
            onPressed: () => 0,
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) => UserCard(userData: userList[index]),
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
    if (_formKey.currentState?.validate() ?? false) {
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
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Enter username'),
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
            'Enter profile username to search:',
            softWrap: true,
            textWidthBasis: TextWidthBasis.parent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 8),
          child: Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.name,
              autofocus: true,
              controller: _textController,
              validator: (String? username) {
                if (username == null || username.isEmpty) {
                  return 'Username cannot be empty.';
                }
                return null;
              },
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
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 22),
          child: Text('Note: Usernames are case sensitive.'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 22),
          child: ElevatedButton(
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
