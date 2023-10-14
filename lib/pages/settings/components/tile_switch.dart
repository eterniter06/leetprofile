import 'package:flutter/material.dart';
import 'package:ui_elements/providers/theme.dart';

class SettingTileSwitch extends StatefulWidget {
  const SettingTileSwitch({
    super.key,
    this.title,
    this.trueDescription,
    this.falseDescription,
    required this.databaseWriteCallback,
    required this.databaseReadCallback,
  });

  final Widget? title;
  final Widget? trueDescription;
  final Widget? falseDescription;
  final Function(bool) databaseWriteCallback;
  final bool Function() databaseReadCallback;

  @override
  State<SettingTileSwitch> createState() => _SettingTileSwitchState();
}

class _SettingTileSwitchState extends State<SettingTileSwitch> {
  _toggleSwitch(bool value) {
    setState(() {
      toggleStatus = value;
    });
    widget.databaseWriteCallback(value);
  }

  late bool toggleStatus;

  @override
  void initState() {
    super.initState();
    toggleStatus = widget.databaseReadCallback();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _toggleSwitch(!toggleStatus),
      child: ListTile(
        title: widget.title,
        subtitle: toggleStatus == true
            ? widget.trueDescription
            : widget.falseDescription,
        subtitleTextStyle: ThemeModeModel.defaultSubtitleTextStyle,
        trailing: Switch(
          value: toggleStatus,
          onChanged: (value) => _toggleSwitch(value),
        ),
      ),
    );
  }
}
