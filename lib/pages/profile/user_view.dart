import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_elements/change_notifiers/user_list.dart';

import 'package:ui_elements/database/settings_database.dart';
import 'package:ui_elements/database/user_database.dart';

import 'package:ui_elements/dataclass/http_wrapper/data_parser.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'package:ui_elements/common_components/refresh_icon_button.dart';

import 'components/badge_card.dart';
import 'components/basic_user_info_card.dart';
import 'components/contests_card.dart';
import 'components/language_section.dart';
import 'components/recent_submission_card.dart';
import 'components/skills_card.dart';
import 'components/solved_problem_card.dart';
import 'components/submission_heatmap_card.dart';
import 'components/nickname_dialog.dart';

class UserView extends StatefulWidget {
  final UserData userData;
  final Widget? refreshIconButton;
  final GlobalKey<RefreshIconButtonState>? refreshIconKey;
  final bool isReorderable;

  const UserView(
      {super.key,
      required this.userData,
      this.refreshIconButton,
      this.refreshIconKey})
      : isReorderable = false;

  const UserView.reorderable({super.key, required this.userData})
      : refreshIconButton = null,
        refreshIconKey = null,
        isReorderable = true;

  final List<String> _defaultOrdering = const [
    'BasicUserInfo',
    'SolvedProblemsCard',
    'SubmissionHeatMap',
    'ContestCard',
    'SkillsCard',
    'LanguageSection',
    'BadgeCard',
    'RecentSubmissionCard'
  ];

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  List<String> profileComponentListAsString = [];
  bool isRefreshing = false;
  List<Widget> profileComponentList = [];
  Map<String, Widget?> componentMapper = {};

  @override
  void initState() {
    super.initState();

    profileComponentListAsString =
        SettingsDatabase.profileComponentOrder() ?? widget._defaultOrdering;

    initMapper();

    for (String componentName in profileComponentListAsString) {
      Widget? widget = componentMapper[componentName];

      if (widget == null) {
        continue;
      }

      profileComponentList.add(widget);
    }
  }

  void initMapper() {
    componentMapper['BasicUserInfo'] = BasicInfoExp(
      userData: widget.userData,
      key: UniqueKey(),
    );

    componentMapper['SolvedProblemsCard'] = SolvedProblemsCard(
      problemData: widget.userData.problemData,
      key: UniqueKey(),
    );

    componentMapper['SubmissionHeatMap'] =
        widget.userData.submissionActivity != null &&
                widget.userData.submissionActivity!.isNotEmpty
            ? SubmissionHeatMap(
                submissionList: widget.userData.submissionActivity!,
                key: UniqueKey(),
              )
            : null;

    componentMapper['ContestCard'] = widget.userData.userContestRanking != null
        ? ContestCard(
            contests: widget.userData.userContestRankingHistory!,
            overallContestData: widget.userData.userContestRanking!,
            key: UniqueKey(),
          )
        : null;

    componentMapper['SkillsCard'] = hasSkills()
        ? SkillsCard(
            fundamentalSkills: widget.userData.fundamentalTags,
            intermediateSkills: widget.userData.intermediateTags,
            advancedSkills: widget.userData.advancedTags,
            key: UniqueKey(),
          )
        : null;

    componentMapper['LanguageSection'] = hasSolvedProblems()
        ? LanguageSection(
            languageProblemList: widget.userData.languageProblemCount!,
            key: UniqueKey(),
          )
        : null;

    componentMapper['BadgeCard'] =
        widget.userData.badges != null && widget.userData.badges!.isNotEmpty
            ? BadgeCard(
                badges: widget.userData.badges!,
                key: UniqueKey(),
              )
            : null;

    componentMapper['RecentSubmissionCard'] = RecentSubmissionCard(
      submissionList: widget.userData.recentAcSubmissionList ?? [],
      key: UniqueKey(),
    );
  }

  Future<void> _refreshUserImpl() async {
    var dataMap =
        await DataParser(username: widget.userData.username).getAllAsJson();

    setState(() {
      widget.userData.update(updatedUser: UserData.fromMap(dataMap: dataMap!));
    });
  }

  bool hasSkills() {
    return (widget.userData.fundamentalTags?.isNotEmpty)! ||
        (widget.userData.intermediateTags?.isNotEmpty)! ||
        (widget.userData.advancedTags?.isNotEmpty)!;
  }

  bool hasSolvedProblems() {
    var problems = widget.userData.languageProblemCount;

    if (problems == null || problems.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userData.nickname ??
            (widget.userData.realname == ""
                ? widget.userData.username
                : widget.userData.realname)),
        actions: widget.isReorderable
            ? null
            : [
                Consumer<UserListModel>(
                  builder: (context, userListModel, child) => IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit nickname',
                      onPressed: () async {
                        String? newNickname = await showDialog(
                          context: context,
                          builder: (context) => NicknameInputDialog(
                            oldNickname: widget.userData.nickname,
                            realname: widget.userData.realname,
                            username: widget.userData.username,
                          ),
                        );

                        if (newNickname == null) {
                          return;
                        }

                        setState(() {
                          widget.userData.updateNickname(newNickname);
                        });

                        await UserDatabase.put(widget.userData);
                      }),
                ),
                RefreshIconButton(
                  globalKey: widget.refreshIconKey,
                  tooltip: 'Refresh user',
                  task: () async {
                    await _refreshUserImpl();
                  },
                  postHook: () async {
                    await UserDatabase.put(widget.userData);
                    if (mounted) {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          showCloseIcon: true,
                          content: Text('User profile has been refreshed.'),
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  tooltip: 'Share leetcode profile',
                  icon: const Icon(Icons.share),
                  onPressed: () => Share.share(
                      'https://leetcode.com/${widget.userData.username}'),
                ),
              ],
      ),
      floatingActionButton: widget.isReorderable
          ? FloatingActionButton(
              tooltip: 'Save layout',
              onPressed: () =>
                  Navigator.of(context).pop(profileComponentListAsString),
              child: const Icon(Icons.save),
            )
          : null,
      body: SafeArea(
        child: widget.isReorderable
            ? ReorderableListView.builder(
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > profileComponentList.length) {
                    newIndex = profileComponentList.length;
                  }
                  if (oldIndex < newIndex) newIndex--;

                  setState(() {
                    Widget component = profileComponentList.removeAt(oldIndex);
                    String componentAsString =
                        profileComponentListAsString.removeAt(oldIndex);

                    profileComponentList.insert(newIndex, component);
                    profileComponentListAsString.insert(
                        newIndex, componentAsString);
                  });
                },
                itemBuilder: (context, index) => profileComponentList[index],
                itemCount: profileComponentList.length,
              )
            : ListView.builder(
                itemBuilder: (context, index) => profileComponentList[index],
                itemCount: profileComponentList.length,
              ),
      ),
    );
  }
}
