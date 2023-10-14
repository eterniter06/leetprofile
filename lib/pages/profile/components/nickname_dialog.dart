import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_elements/providers/theme.dart';

class NicknameInputDialog extends StatefulWidget {
  const NicknameInputDialog({
    super.key,
    this.oldNickname,
    this.username,
    this.realname,
  });

  final String? oldNickname;
  final String? realname;
  final String? username;

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
          duration: const Duration(seconds: 2),
          showCloseIcon: true,
          content: Text(widget.oldNickname == null
              ? 'Nickname set: ${_textController.text}'
              : 'Nickname changed. ${widget.oldNickname} -> ${_textController.text}'),
        ),
      );

      Navigator.pop(context, _textController.text);
    }
  }

  String displayName() {
    if (widget.oldNickname == null) {
      return widget.realname == "" ? widget.username! : widget.realname!;
    }

    return widget.oldNickname!;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(26, 12, 26, 16),
      title: SvgPicture.asset(
        'assets/profile_details_yellow.svg',
        height: 200,
      ),
      children: [
        RichText(
          text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 24,
                  ),
              text: widget.oldNickname == null
                  ? 'Enter a nickname for\n'
                  : 'Enter a new nickname for\n',
              children: [
                TextSpan(
                  text: displayName(),
                  style: const TextStyle(
                    inherit: true,
                    color: ThemeModeModel.lightPrimaryInverse,
                  ),
                ),
              ]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // RichText(
        //   text: TextSpan(
        //     text: 'User: ',
        //     style: DefaultTextStyle.of(context).style,
        //     children: [
        //       TextSpan(
        //         text: displayName(),
        //         style: const TextStyle(
        //           inherit: true,
        //           color: ThemeModeModel.lightPrimaryInverse,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 16),
        Form(
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
              label: Text('Nickname'),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 8),
            ),
            enableSuggestions: true,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => submitNickname(),
          child: Text(
              widget.oldNickname == null ? 'Set nickname' : 'Change nickname'),
        ),
      ],
    );
  }
}
