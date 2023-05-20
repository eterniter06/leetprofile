import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/components/database/database.dart';
import 'package:ui_elements/components/dialog/setting_option.dart';
import 'package:ui_elements/components/theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    themeMode = SettingsDatabase.themeMode();
  }

  String _themeModeAsString(ThemeMode themeMode) {
    String themeModeAsString = themeMode.toString();
    String themeModeName =
        themeModeAsString.substring(themeModeAsString.indexOf('.') + 1);

    String finalModeString = themeModeName.replaceFirst(
        themeModeName[0], themeModeName[0].toUpperCase());

    return finalModeString;
  }

  void _updateThemeMode(ThemeMode chosenTheme) async {
    await SettingsDatabase.changeTheme(chosenTheme);
    setState(() {
      themeMode = chosenTheme;
    });

    if (context.mounted) {
      Provider.of<ThemeModeModel>(context, listen: false)
          .changeThemeMode(chosenTheme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: Text(
              'General',
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
          ),
          const SettingTileSwitch(
            title: Text(
              'Refresh all users when app loads',
              style: TextStyle(color: Colors.white),
            ),
            trueDescription: Text(
              'Profiles will be updated when app loads',
            ),
            falseDescription: Text(
              'Profiles will not be updated on app load',
            ),
            databaseWriteCallback:
                SettingsDatabase.changeRefreshAllUsersOnStartup,
            databaseReadCallback: SettingsDatabase.refreshAllUsersOnStartup,
          ),
          const Divider(
            height: 0,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: Text(
              'Theme',
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
          ),
          SettingTile(
            title: const Text(
              'Theme',
              style: TextStyle(color: Colors.white),
            ),
            description:
                Text('Current theme: ${_themeModeAsString(themeMode)}'),
            callback: () {
              showDialog(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setDialogState) {
                  var themeDialogContext = context;
                  return SettingDialog(
                    headerText: 'Choose Theme',
                    children: [
                      RadioListTile.adaptive(
                        title: const Text('Dark Mode'),
                        value: ThemeMode.dark,
                        groupValue: themeMode,
                        onChanged: (value) {
                          _updateThemeMode(value!);
                          setDialogState(() {
                            themeMode = value;
                          });
                          Navigator.pop(themeDialogContext);
                        },
                      ),
                      RadioListTile.adaptive(
                        title: const Text('Light Mode'),
                        value: ThemeMode.light,
                        groupValue: themeMode,
                        onChanged: (value) {
                          _updateThemeMode(value!);
                          setDialogState(() {
                            themeMode = value;
                          });
                          Navigator.pop(themeDialogContext);
                        },
                      ),
                      RadioListTile.adaptive(
                        title: const Text('System default'),
                        value: ThemeMode.system,
                        groupValue: themeMode,
                        onChanged: (value) {
                          _updateThemeMode(value!);
                          setDialogState(() {
                            themeMode = value;
                          });
                          Navigator.pop(themeDialogContext);
                        },
                      )
                    ],
                  );
                }),
              );
            },
          ),
          const Divider(
            height: 0,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: Text(
              'Data',
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
          ),
          const SettingTile(
            title: Text(
              'Export users',
              style: TextStyle(color: Colors.white),
            ),
            description: Text(
                'Save all usernames in the app as a csv file that can be imported. No detail other than the username is exported'),
          ),
          const SettingTile(
            title: Text(
              'Import users',
              style: TextStyle(color: Colors.white),
            ),
            description: Text(
              'Load all users from the import file',
            ),
          ),
          SettingTile(
            title: const Text(
              'Clear Data',
              style: TextStyle(color: Colors.red),
            ),
            description: Text(
              'Remove all users and their stored data. This cannot be undone',
              style: TextStyle(color: Colors.red[100]),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({super.key, this.title, this.description, this.callback});

  final Widget? title;
  final Widget? description;
  final void Function()? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: ListTile(
        title: title,
        subtitle: description,
      ),
    );
  }
}

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
        trailing: Switch(
          value: toggleStatus,
          onChanged: (value) => _toggleSwitch(value),
        ),
      ),
    );
  }
}
