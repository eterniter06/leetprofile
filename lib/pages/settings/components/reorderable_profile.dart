import 'package:flutter/material.dart';
import 'package:ui_elements/database/settings_database.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/components/badge_card.dart';
import 'package:ui_elements/pages/profile/components/basic_user_info_card.dart';
import 'package:ui_elements/common_components/refresh_icon_button.dart';
import 'package:ui_elements/pages/profile/components/contests_card.dart';
import 'package:ui_elements/pages/profile/components/language_section.dart';
import 'package:ui_elements/pages/profile/components/recent_submission_card.dart';
import 'package:ui_elements/pages/profile/components/skills_card.dart';
import 'package:ui_elements/pages/profile/components/solved_problem_card.dart';

class ReorderableUserPage extends StatefulWidget {
  final UserData userData;
  const ReorderableUserPage(
      {super.key, required this.userData, this.refreshIconKey});
  final GlobalKey<RefreshIconButtonState>? refreshIconKey;
  @override
  State<ReorderableUserPage> createState() => _ReorderableUserPageState();
}

List<String> profileComponentListAsString = [];

class _ReorderableUserPageState extends State<ReorderableUserPage> {
  bool isRefreshing = false;
  late List<Widget> profileComponentList;

  @override
  void initState() {
    super.initState();

    profileComponentList = [
      BasicUserInfo(userData: widget.userData, key: UniqueKey()),
      SolvedProblemsCard(
          problemData: widget.userData.problemData, key: UniqueKey()),
      // SubmissionHeatMap(),
      ContestCard(
          contests: widget.userData.userContestRankingHistory!,
          overallContestData: widget.userData.userContestRanking!,
          key: UniqueKey()),
      SkillsCard(
        key: UniqueKey(),
        fundamentalSkills: widget.userData.fundamentalTags,
        intermediateSkills: widget.userData.intermediateTags,
        advancedSkills: widget.userData.advancedTags,
      ),
      LanguageSection(
          key: UniqueKey(),
          languageProblemList: widget.userData.languageProblemCount!),
      BadgeCard(key: UniqueKey(), badges: widget.userData.badges!),
      RecentSubmissionCard(
          key: UniqueKey(),
          submissionList: widget.userData.recentAcSubmissionList ?? []),
    ];

    profileComponentList.forEach((element) {
      profileComponentListAsString.add(element.toString());
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
        // actions: [
        //   IconButton(
        //     tooltip: 'Save layout',
        //     icon: const Icon(Icons.check),
        //     onPressed: () =>
        //         Share.share('https://leetcode.com/${widget.userData.username}'),
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pop(profileComponentListAsString),
        child: const Icon(Icons.check),
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
              profileComponentList.insert(newIndex, component);
            });
          },
          itemBuilder: (context, index) => profileComponentList[index],
          itemCount: profileComponentList.length,
        ),
      ),
    );
  }
}
