import 'package:flutter/material.dart';

class SettingDialog extends StatelessWidget {
  const SettingDialog({super.key, this.headerText, this.children});
  final String? headerText;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(headerText!),
      children: children,
    );
  }
}
