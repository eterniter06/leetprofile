import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:ui_elements/components/dialog/setting_option.dart';
import 'package:ui_elements/components/theme.dart';
import 'package:ui_elements/pages/user_list_provider.dart';

import '../components/database/settings_database.dart';

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
            onTap: () {
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
          Consumer<UserListModel>(
            builder: (context, userListModel, child) => SettingTile(
              title: const Text(
                'Export users',
                style: TextStyle(color: Colors.white),
              ),
              description: const Text(
                  'Save all usernames in the app to a file that can be imported. No detail other than the username is exported'),
              onTap: () async {
                if (userListModel.isEmpty()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No data to export'),
                      duration: Duration(seconds: 2),
                      showCloseIcon: true,
                    ),
                  );
                  return;
                }

                String time = DateTime.now()
                    .toLocal()
                    .toString()
                    .replaceAll('-', '_')
                    .replaceAll(':', '')
                    .replaceAll(' ', '');
                time = time.substring(0, time.indexOf('.'));

                String csvFilename = "LP_$time.csv";

                //Todo: Add option to export as profile links or as usernames
                //Todo: Contemplate using json vs csv

                String usernameListAsString =
                    userListModel.exportUsernamesAsCSV(withTLD: false);

                String? directory = await FilePicker.platform.getDirectoryPath(
                  dialogTitle: 'Pick export location',
                );

                if (directory == null) {
                  return;
                }

                File exportFile = File(p.join(directory, csvFilename));
                await exportFile.writeAsString(usernameListAsString);

                if (mounted) {
                  ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
                    content: Text('Export file created in Folder: $directory'),
                    duration: const Duration(seconds: 6),
                  ));
                }
              },
            ),
          ),
          Consumer<UserListModel>(
            builder: (context, userListModel, child) => SettingTile(
              title: const Text(
                'Import users',
                style: TextStyle(color: Colors.white),
              ),
              description: const Text(
                'Load all users from the import file',
              ),
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  allowedExtensions: ['json', 'csv'],
                  type: FileType.custom,
                  dialogTitle: 'Pick import file',
                );

                if (result == null) {
                  return;
                }

                String importFile = result.files[0].path!;
                final inputFile = File(importFile).openRead();

                final csvList = await inputFile
                    .transform(utf8.decoder)
                    .transform(const CsvToListConverter())
                    .toList();

                for (List columns in csvList) {
                  String column = columns[0];

                  List<String> values = column.split('\n');
                  String header = values[0].trim().toLowerCase();

                  if (header.toLowerCase().trim() == 'username') {
                    values.remove(values[0]);
                    var futureGroup = <Future>[];

                    bool listUpdated = false;
                    for (var username in values) {
                      if (userListModel.inList(username)) {
                        continue;
                      }

                      listUpdated = true;
                      futureGroup
                          .add(userListModel.createUserFromUsername(username));
                    }

                    if (!listUpdated && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('All users are already in list'),
                        showCloseIcon: true,
                      ));
                      return;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Loading user data'),
                        duration: Duration(seconds: 2),
                        showCloseIcon: true,
                      ));
                    }

                    List userList = await Future.wait(futureGroup);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Users added'),
                        showCloseIcon: true,
                      ));
                    }
                    userListModel.importUsersFromList(userList);
                  }
                }
              },
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
  const SettingTile({super.key, this.title, this.description, this.onTap});

  final Widget? title;
  final Widget? description;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
