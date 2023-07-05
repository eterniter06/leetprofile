import 'package:flutter/material.dart';

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
              'Nickname changed. ${widget.oldNickname} -> ${_textController.text}'),
        ),
      );

      Navigator.pop(context, _textController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Enter nickname'),
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
