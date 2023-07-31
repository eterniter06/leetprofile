import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_elements/change_notifiers/user_list.dart';

import 'package:ui_elements/database/user_database.dart';

import 'package:ui_elements/dataclass/http_wrapper/data_parser.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/components/language_section.dart';
import 'package:ui_elements/common_components/refresh_icon_button.dart';

import 'components/badge_card.dart';
import 'components/basic_user_info_card.dart';
import 'components/contests_card.dart';
import 'components/nickname_dialog.dart';
import 'components/recent_submission_card.dart';
import 'components/skills_card.dart';
import 'components/solved_problem_card.dart';

class UserPage extends StatefulWidget {
  final UserData userData;
  const UserPage({super.key, required this.userData, this.refreshIconKey});
  final GlobalKey<RefreshIconButtonState>? refreshIconKey;
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isRefreshing = false;

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
        actions: [
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
            onPressed: () =>
                Share.share('https://leetcode.com/${widget.userData.username}'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            BasicUserInfo(userData: widget.userData),
            SolvedProblemsCard(problemData: widget.userData.problemData),
            // SubmissionHeatMap(),
            if (widget.userData.userContestRanking != null)
              ContestCard(
                contests: widget.userData.userContestRankingHistory!,
                overallContestData: widget.userData.userContestRanking!,
              ),
            if (hasSkills())
              SkillsCard(
                fundamentalSkills: widget.userData.fundamentalTags,
                intermediateSkills: widget.userData.intermediateTags,
                advancedSkills: widget.userData.advancedTags,
              ),
            if (hasSolvedProblems())
              LanguageSection(
                  languageProblemList: widget.userData.languageProblemCount!),
            if (widget.userData.badges != null &&
                (widget.userData.badges!.isNotEmpty))
              BadgeCard(badges: widget.userData.badges!),
            RecentSubmissionCard(
                submissionList: widget.userData.recentAcSubmissionList ?? []),
          ],
        ),
      ),
    );
  }
}
