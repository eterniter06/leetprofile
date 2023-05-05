import 'package:flutter/material.dart';

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
          duration: const Duration(seconds: 3),
          showCloseIcon: true,
          closeIconColor: Colors.amber,
          content: RichText(
            text: TextSpan(
              text: 'Searching user: ',
              children: [
                TextSpan(
                  text: _textController.text,
                  style: const TextStyle(color: Colors.amber),
                )
              ],
            ),
          ),
        ),
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