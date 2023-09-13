import 'package:flutter/material.dart';
import 'package:ui_elements/database/settings_database.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'package:ui_elements/pages/profile/components/badge_card.dart';
import 'package:ui_elements/pages/profile/components/basic_user_info_card.dart';
import 'package:ui_elements/pages/profile/components/basic_user_info_card2.dart';
import 'package:ui_elements/pages/profile/components/contests_card.dart';
import 'package:ui_elements/pages/profile/components/language_section.dart';
import 'package:ui_elements/pages/profile/components/recent_submission_card.dart';
import 'package:ui_elements/pages/profile/components/skills_card.dart';
import 'package:ui_elements/pages/profile/components/solved_problem_card.dart';
import 'package:ui_elements/pages/profile/components/submission_heatmap_card.dart';

class ReorderableUserPage extends StatefulWidget {
  final UserData userData;
  const ReorderableUserPage({super.key, required this.userData});
  @override
  State<ReorderableUserPage> createState() => _ReorderableUserPageState();

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
}

class _ReorderableUserPageState extends State<ReorderableUserPage> {
  List<String> profileComponentListAsString = [];
  bool isRefreshing = false;
  late List<Widget> profileComponentList = [];
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
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save layout',
        onPressed: () =>
            Navigator.of(context).pop(profileComponentListAsString),
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: ReorderableListView.builder(
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
              profileComponentListAsString.insert(newIndex, componentAsString);
            });
          },
          itemBuilder: (context, index) => profileComponentList[index],
          itemCount: profileComponentList.length,
        ),
      ),
    );
  }
}
