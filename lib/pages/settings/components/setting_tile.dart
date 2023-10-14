import 'package:flutter/material.dart';
import 'package:ui_elements/providers/theme.dart';

class SettingTile extends StatelessWidget {
  const SettingTile(
      {super.key,
      this.title,
      this.description,
      this.titleTextStyle,
      this.subtitleTextStyle,
      this.onTap});

  final Widget? title;
  final Widget? description;
  final void Function()? onTap;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: onTap == null ? false : true,
      titleTextStyle: titleTextStyle,
      subtitleTextStyle:
          subtitleTextStyle ?? ThemeModeModel.defaultSubtitleTextStyle,
      onTap: onTap,
      title: title,
      subtitle: description,
    );
  }
}
