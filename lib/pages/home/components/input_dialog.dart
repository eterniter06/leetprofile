import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/providers/theme.dart';

class UserInputDialog extends StatefulWidget {
  const UserInputDialog({
    super.key,
  });

  @override
  State<UserInputDialog> createState() => _UserInputDialogState();
}

class _UserInputDialogState extends State<UserInputDialog> {
  final _usernameController = TextEditingController();
  final _usernameFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void submitUserInput() {
    if (_usernameFormKey.currentState?.validate() ?? false) {
      setState(() {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          showCloseIcon: true,
          content: Text(
            'Searching user: ${_usernameController.text}',
          ),
        ),
      );

      Navigator.pop(context, _usernameController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);

    return SimpleDialog(
      semanticLabel: 'Profile input dialog Box',
      title: SvgPicture.asset(
        // More accurate
        // 'assets/undraw_add_friends_re_3xte.svg',

        // Somehow has a better vibe
        'assets/profile_data_yellow.svg',
        fit: BoxFit.contain,
        height: 160,
      ),
      contentPadding: const EdgeInsets.fromLTRB(26, 12, 26, 16),
      children: [
        const SizedBox(
          height: 16,
        ),
        Consumer<ThemeModeModel>(
          builder: (context, themeModeModel, child) => Text(
            'Add a profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: themeModeModel.equivalentThemeMode(platformBrightness) ==
                      ThemeMode.light
                  ? ThemeModeModel.lightPrimaryInverse
                  : ThemeModeModel.lightPrimary,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Enter profile link or username:',
          softWrap: true,
          textWidthBasis: TextWidthBasis.parent,
        ),
        const SizedBox(height: 16),
        Form(
          key: _usernameFormKey,
          child: TextFormField(
            keyboardType: TextInputType.name,
            autofocus: true,
            controller: _usernameController,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
            ),
            enableSuggestions: true,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => submitUserInput(),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Search '),
              Icon(Icons.search),
            ],
          ),
        ),
      ],
    );
  }
}
