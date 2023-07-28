import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_elements/change_notifiers/user_list.dart';

import 'package:ui_elements/database/user_database.dart';

import 'package:ui_elements/dataclass/http_wrapper/data_parser.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/refresh_icon_button.dart';

import 'components/nickname_dialog.dart';
import 'components/difficulty_section.dart';
import 'components/language_section.dart';
import 'components/recent_submission_list.dart';
import 'components/social_media_button.dart';

class UserPage extends StatefulWidget {
  final UserData userData;
  const UserPage({super.key, required this.userData, this.refreshIconKey});
  final GlobalKey<RefreshIconButtonState>? refreshIconKey;
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isRefreshing = false;

  num getSolvedCount(ProblemData? problemData) {
    return problemData == null
        ? 0
        : problemData.easySolved +
            problemData.mediumSolved +
            problemData.hardSolved;
  }

  Future<void> _refreshUserImpl() async {
    var dataMap =
        await DataParser(username: widget.userData.username).getAllAsJson();

    setState(() {
      widget.userData.update(updatedUser: UserData.fromMap(dataMap: dataMap!));
    });
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Image.network(
                      widget.userData.avatar,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userData.username,
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                            'Contest Rating: ${widget.userData.userContestRanking?.rating.round()}'),
                        Text(
                            'Contests Attended: ${widget.userData.userContestRanking?.attendedContestsCount}'),
                        Text(
                            'Global Ranking: ${widget.userData.userContestRanking?.globalRanking}'),
                        Text(
                            'Top percentage: ${widget.userData.userContestRanking?.topPercentage}'),
                        if (widget.userData.githubUrl != null ||
                            widget.userData.linkedinUrl != null) ...[
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.userData.linkedinUrl != null) ...[
                                SocialMediaButton(
                                  icon: FontAwesomeIcons.linkedin,
                                  link: widget.userData.linkedinUrl!,
                                  color: const Color(0xff0077b5),
                                  socialMedia: 'Linkedin',
                                ),
                                const SizedBox(width: 8),
                              ],
                              if (widget.userData.githubUrl != null)
                                SocialMediaButton(
                                  icon: FontAwesomeIcons.github,
                                  link: widget.userData.githubUrl!,
                                  // color: const Color(0xff171515),
                                  // Workaround so that github logo is visible against dark background
                                  // Check to see if logo color and background can be adjusted
                                  color: MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.dark
                                      ? const Color(0xffffffff)
                                      : const Color(0xff171515),
                                  socialMedia: 'Github',
                                )
                            ],
                          )
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Solved Problems',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Difficulty',
                        ),
                      ),
                      DifficultySection(
                        problemData: widget.userData.problemData,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 12.0,
                        ),
                        child: Text(
                          'Language',
                        ),
                      ),
                      LanguageSection(
                          languageProblemList:
                              widget.userData.languageProblemCount ?? []),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Total problems solved: ${getSolvedCount(widget.userData.problemData)}',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              RecentSubmissionList(
                  submissionList: widget.userData.recentAcSubmissionList ?? []),
            ],
          ),
        ),
      ),
    );
  }
}
