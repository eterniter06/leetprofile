import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
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
  final _nicknameController = TextEditingController();
  final _nicknameFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void submitNickname() {
    if (_nicknameFormKey.currentState?.validate() ?? false) {
      setState(() {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(widget.oldNickname == null
              ? 'Nickname set: ${_nicknameController.text}'
              : 'Nickname changed. ${widget.oldNickname} -> ${_nicknameController.text}'),
        ),
      );

      Navigator.pop(context, _nicknameController.text);
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
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);

    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(26, 12, 26, 16),
      title: SvgPicture.asset(
        'assets/profile_details_yellow.svg',
        height: 200,
      ),
      children: [
        Consumer<ThemeModeModel>(
          builder: (context, themeModeModel, child) => Text.rich(
            TextSpan(
                style: DefaultTextStyle.of(context).style.copyWith(
                      color: themeModeModel
                                  .equivalentThemeMode(platformBrightness) ==
                              ThemeMode.light
                          ? ThemeModeModel.black
                          : ThemeModeModel.white,
                      fontSize: 24,
                    ),
                text: widget.oldNickname == null
                    ? 'Enter a nickname for\n'
                    : 'Enter a new nickname for\n',
                children: [
                  TextSpan(
                    text: displayName(),
                    style: TextStyle(
                      inherit: true,
                      color: themeModeModel
                                  .equivalentThemeMode(platformBrightness) ==
                              ThemeMode.light
                          ? ThemeModeModel.lightPrimaryInverse
                          : ThemeModeModel.lightPrimary,
                    ),
                  ),
                ]),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Form(
          key: _nicknameFormKey,
          child: TextFormField(
            autofocus: true,
            controller: _nicknameController,
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
