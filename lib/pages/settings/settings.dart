import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

import 'package:ui_elements/database/settings_database.dart';
import 'package:ui_elements/pages/profile/profile.dart';

import 'components/setting_option.dart';

import 'package:ui_elements/change_notifiers/theme.dart';
import 'package:ui_elements/change_notifiers/user_list.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late ThemeMode themeMode;
  late int submissionCount;

  @override
  void initState() {
    super.initState();
    themeMode = SettingsDatabase.themeMode();
    submissionCount = SettingsDatabase.numberOfShownUserSubmissions();
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
            ),
          ),
          const SettingTileSwitch(
            title: Text(
              'Refresh all users when app loads',
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
          SettingTile(
            title: const Text('Number of user submissions shown by default'),
            description: Text(
                'The number of submisisons shown when the submission list is collapsed. Submissions shown: $submissionCount'),
            onTap: () async {
              int? count = await showDialog(
                context: context,
                builder: (context) => const SubmissionCountDialogBox(),
              );

              if (count != null) {
                SettingsDatabase.changeNumberOfShownUserSubmissions(count);
                setState(() {
                  submissionCount = count;
                });
              }
            },
          ),
          SettingTile(
            title: const Text('Change profile layout'),
            description:
                const Text('Change the way profile details are ordered'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Consumer<UserListModel>(
                  builder: (context, userList, child) =>
                      UserPage(userData: userList.userList[0]),
                ),
              ),
            ),
          ),
          const Divider(
            height: 0,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: Text(
              'Theme',
            ),
          ),
          SettingTile(
            title: const Text(
              'Theme',
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
            ),
          ),
          Consumer<UserListModel>(
            builder: (context, userListModel, child) => SettingTile(
              title: const Text(
                'Export users',
              ),
              description: const Text(
                  'Save all usernames in the app to a file that can be imported. No detail other than the username is exported'),
              onTap: userListModel.isEmpty()
                  ? null
                  : () async {
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

                      String? directory =
                          await FilePicker.platform.getDirectoryPath(
                        dialogTitle: 'Pick export location',
                      );

                      if (directory == null) {
                        return;
                      }

                      File exportFile = File(p.join(directory, csvFilename));
                      await exportFile.writeAsString(usernameListAsString);

                      if (mounted) {
                        ScaffoldMessenger.maybeOf(context)
                            ?.showSnackBar(SnackBar(
                          content:
                              Text('Export file created in Folder: $directory'),
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
                      if (userListModel.contains(username)) {
                        continue;
                      }

                      listUpdated = true;
                      futureGroup
                          .add(UserListModel.createUserFromUsername(username));
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
                    userListModel.syncDatabase();
                  }
                }
              },
            ),
          ),
          Consumer<UserListModel>(
            builder: (context, userListModel, child) => SettingTile(
              title: const Text(
                'Clear Data',
              ),
              description: const Text(
                'Remove all users and their stored data. This cannot be undone',
              ),
              onTap: userListModel.isEmpty()
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Delete all data?'),
                          content: const Text(
                              'Existing data will be erased. You can still restore the users using a import file.'),
                          actions: [
                            ElevatedButton(
                              child: const Text(
                                'Delete data',
                              ),
                              onPressed: () async {
                                String snackBarMessage = userListModel.isEmpty()
                                    ? 'Nothing to delete. Add some profiles first.'
                                    : 'Profiles deleted';

                                if (!userListModel.isEmpty()) {
                                  await userListModel.deleteAllDatabaseSync();
                                }

                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(snackBarMessage),
                                      showCloseIcon: true,
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                  Navigator.pop(dialogContext);
                                }
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.pop(dialogContext),
                            ),
                          ],
                        ),
                      );
                    },
            ),
          ),
        ],
      ),
    );
  }
}

class SubmissionCountDialogBox extends StatefulWidget {
  const SubmissionCountDialogBox({super.key});

  @override
  State<SubmissionCountDialogBox> createState() =>
      _SubmissionCountDialogBoxState();
}

class _SubmissionCountDialogBoxState extends State<SubmissionCountDialogBox> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submitCountValue() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, int.parse(_textController.text));
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Change user submission count'),
      semanticLabel:
          'Dialog box to change the number of user submissions shown by default',
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 8),
          child: Form(
            key: _formKey,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofocus: true,
              controller: _textController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              validator: (String? count) {
                if (count == null || count.isEmpty) {
                  return 'Submission to show cannot be empty. If you do not want any submission to be shown by default, enter 0';
                }
                return null;
              },
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: false),
              onFieldSubmitted: (value) => submitCountValue(),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                label: Text('Submission count'),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 8),
                errorMaxLines: 2,
              ),
              enableSuggestions: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 22),
          child: ElevatedButton(
            onPressed: () => submitCountValue(),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Change'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

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
      subtitleTextStyle: subtitleTextStyle,
      onTap: onTap,
      title: title,
      subtitle: description,
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
