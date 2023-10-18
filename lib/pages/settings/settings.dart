import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/user_view.dart';

import 'package:ui_elements/database/settings_database.dart';
import 'package:ui_elements/providers/settings.dart';

import 'components/section.dart';
import 'components/setting_option.dart';

import 'package:ui_elements/providers/theme.dart';
import 'package:ui_elements/providers/user_list.dart';

import 'components/setting_tile.dart';
import 'components/submission_count_dialog.dart';
import 'components/tile_switch.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late ThemeMode themeMode;
  late int submissionCount;
  late int tagCount;

  @override
  void initState() {
    super.initState();
    themeMode = SettingsDatabase.themeMode();
    submissionCount = SettingsDatabase.numberOfShownUserSubmissions();
    tagCount = SettingsDatabase.numberOfShownTags();
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
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Section(
            header: 'Profile UI',
            children: [
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
              Consumer<SettingsModel>(
                builder: (context, settingsModel, child) => SettingTileSwitch(
                  title: const Text('Show usernames on homescreen'),
                  trueDescription: const Text(
                      'Usernames are shown for each profile in the home screen'),
                  falseDescription: const Text('Usernames are not shown'),
                  databaseReadCallback: () => settingsModel.showUsername,
                  // Use anonymous functiona to execute actual function;
                  // Yes this does not seem pretty and a proper fix would be nice
                  databaseWriteCallback: (_) =>
                      settingsModel.toggleUsernameOnHomeScreenVisibility(),
                ),
              ),
              const SettingTileSwitch(
                databaseReadCallback: SettingsDatabase.is24HourFormat,
                databaseWriteCallback: SettingsDatabase.set24HourFormat,
                trueDescription: Text('Using 24 hour format'),
                falseDescription: Text('Using Am/Pm'),
                title: Text('Use 24 hour format'),
              ),
              SettingTile(
                title:
                    const Text('Number of user submissions shown by default'),
                description: Consumer<ThemeModeModel>(
                  builder: (context, themeModel, child) => Text.rich(
                    TextSpan(
                      style: ThemeModeModel.defaultSubtitleTextStyle,
                      text:
                          'The number of submisisons shown when the submission list is collapsed.\nSubmissions shown: ',
                      children: [
                        TextSpan(
                          text: '$submissionCount',
                          style: ThemeModeModel.defaultSubtitleTextStyle
                              .copyWith(
                                  color: themeModel.equivalentThemeMode(
                                              platformBrightness) ==
                                          ThemeMode.light
                                      ? ThemeModeModel.lightSecondaryInverse
                                      : ThemeModeModel.lightPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  int? count = await showDialog(
                    context: context,
                    builder: (context) => ChangeCountDialogBox(
                      title: 'Change user submission count',
                      subtitle:
                          'Submissions shown unexpanded: $submissionCount',
                      semanticLabel:
                          'Dialog box to change the number of user submissions shown by default',
                      previousSubmissionCount: submissionCount,
                    ),
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
                title: const Text('Number of tags shown by default'),
                description: Consumer<ThemeModeModel>(
                  builder: (context, themeModel, child) => Text.rich(
                    TextSpan(
                      style: ThemeModeModel.defaultSubtitleTextStyle,
                      text:
                          'The number of problem tags shown by default.\nTags shown: ',
                      children: [
                        TextSpan(
                          text: '$tagCount',
                          style: ThemeModeModel.defaultSubtitleTextStyle
                              .copyWith(
                                  color: themeModel.equivalentThemeMode(
                                              platformBrightness) ==
                                          ThemeMode.light
                                      ? ThemeModeModel.lightSecondaryInverse
                                      : ThemeModeModel.lightPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  int? count = await showDialog(
                    context: context,
                    builder: (context) => ChangeCountDialogBox(
                      title: 'Change default tag count',
                      subtitle: 'Tags shown by default: $tagCount',
                      semanticLabel:
                          'Dialog box to change the number of tags shown by default',
                      previousSubmissionCount: tagCount,
                    ),
                  );

                  if (count != null) {
                    SettingsDatabase.changeNumberOfShownTags(count);
                    setState(() {
                      tagCount = count;
                    });
                  }
                },
              ),
              SettingTile(
                title: const Text('Change profile layout'),
                description: const Text(
                    'Change the way profile details are ordered. Hold section name and then drag and drop to set your own layout.'),
                onTap: () async {
                  List<String>? order = await Navigator.of(context).push(
                    // Todo: Look into PageRouteBuilder for animiation
                    MaterialPageRoute(
                      builder: (context) => Consumer<UserListModel>(
                        builder: (context, userList, child) =>
                            UserView.reorderableAbsorbPointer(
                                userData: UserData.dummyUser),
                      ),
                    ),
                  );
                  if (order != null) {
                    SettingsDatabase.saveProfileComponentsOrder(order);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile layout saved'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
          const Divider(
            height: 0,
          ),
          Section(
            header: 'Theme',
            children: [
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
            ],
          ),
          const Divider(
            height: 0,
          ),
          Section(
            header: 'Data',
            children: [
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

                          String usernameListAsString = userListModel
                              .exportUsernamesAsCSV(withTLD: false);

                          String? directory =
                              await FilePicker.platform.getDirectoryPath(
                            dialogTitle: 'Pick export location',
                          );

                          if (directory == null) {
                            return;
                          }

                          File exportFile =
                              File(p.join(directory, csvFilename));
                          await exportFile.writeAsString(usernameListAsString);

                          if (mounted) {
                            ScaffoldMessenger.maybeOf(context)
                                ?.showSnackBar(SnackBar(
                              content: Text(
                                  'Export file created in Folder: $directory'),
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
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
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
                          futureGroup.add(
                              UserListModel.createUserFromUsername(username));
                        }

                        if (!listUpdated && mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('All users are already in list'),
                            showCloseIcon: true,
                          ));
                          return;
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Loading user data'),
                              duration: Duration(seconds: 2),
                              showCloseIcon: true,
                            ));
                          }
                        }

                        List userList = await Future.wait(futureGroup);
                        if (mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
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
              Consumer2<UserListModel, ThemeModeModel>(
                builder: (context, userListModel, themeModel, child) =>
                    SettingTile(
                  title: const Text(
                    'Clear Data',
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Overpass',
                    color: themeModel.equivalentThemeMode(platformBrightness) ==
                            ThemeMode.light
                        ? Colors.red.shade600
                        : Colors.red.shade400,
                  ),
                  description: Text.rich(TextSpan(
                    style: ThemeModeModel.defaultSubtitleTextStyle,
                    text: 'Remove all users and their stored data. ',
                    children: [
                      TextSpan(
                        text: 'This cannot be undone',
                        style: ThemeModeModel.defaultSubtitleTextStyle.copyWith(
                            color: themeModel.equivalentThemeMode(
                                        platformBrightness) ==
                                    ThemeMode.light
                                ? Colors.red.shade900
                                : Colors.red.shade400),
                      ),
                    ],
                  )),
                  onTap: userListModel.isEmpty()
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              title: Text('Delete all data?',
                                  style: TextStyle(
                                      color: themeModel.equivalentThemeMode(
                                                  platformBrightness) ==
                                              ThemeMode.light
                                          ? Colors.red.shade700
                                          : Colors.red.shade400)),
                              content: const Text(
                                  'This will delete all stored users and their profile data on this app. Your import files will not be deleted.'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Colors.red.shade600;
                                      }
                                      return const Color.fromARGB(
                                          255, 241, 107, 107);
                                    }),
                                    foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Colors.white;
                                      }
                                      return Colors.white;
                                    }),
                                  ),
                                  child: const Text(
                                    'Delete data',
                                  ),
                                  onPressed: () async {
                                    String snackBarMessage = userListModel
                                            .isEmpty()
                                        ? 'Nothing to delete. Add some profiles first.'
                                        : 'Profiles deleted';

                                    if (!userListModel.isEmpty()) {
                                      await userListModel
                                          .deleteAllDatabaseSync();
                                    }

                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
        ],
      ),
    );
  }
}
