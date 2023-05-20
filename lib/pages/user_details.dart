import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_elements/components/database/user_database.dart';
import 'package:ui_elements/components/recent_submission_list.dart';

import '../components/dataclass/http_wrapper/data_parser.dart';
import '../components/dataclass/user_class/userdata.dart';
import '../components/difficulty_section.dart';
import '../components/language_section.dart';
import '../components/social_media_button.dart';

class UserPage extends StatefulWidget {
  final UserData userData;
  const UserPage({super.key, required this.userData});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  num getSolvedCount(ProblemData? problemData) {
    return problemData == null
        ? 0
        : problemData.easySolved +
            problemData.mediumSolved +
            problemData.hardSolved;
  }

  double valueScaler(BuildContext context, num value) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double ratio = width / 590.0;

    return ratio * value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userData.nickname),
        actions: [
          IconButton(
            tooltip: 'Refresh user',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () async {
              var dataMap = await DataParser(username: widget.userData.username)
                  .getAllAsJson();

              setState(() {
                widget.userData
                    .update(updatedUser: UserData.fromMap(dataMap: dataMap!));
              });

              var isar = await UserDatabase.isar();
              isar!.writeTxn(() async {
                await isar.userDatas.put(widget.userData);
              });

              setState(() {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    showCloseIcon: true,
                    closeIconColor: Colors.amber,
                    content: Text('User profile has been refreshed.'),
                  ),
                );
              });
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
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: valueScaler(context, 24.0),
                            fontFamily: 'Overpass',
                          ),
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
                          SizedBox(
                            height: valueScaler(context, 20),
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
                                  valueScaler: valueScaler,
                                ),
                                SizedBox(width: valueScaler(context, 8)),
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
                                  valueScaler: valueScaler,
                                )
                            ],
                          )
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(valueScaler(context, 8.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(valueScaler(context, 8.0)),
                        child: Text(
                          'Solved Problems',
                          style: TextStyle(
                            fontSize: valueScaler(context, 24),
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          valueScaler(context, 12.0),
                        ),
                        child: Text(
                          'Difficulty',
                          style: TextStyle(
                            fontSize: valueScaler(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      DifficultySection(
                        problemData: widget.userData.problemData,
                        valueScaler: valueScaler,
                      ),
                      SizedBox(
                        height: valueScaler(context, 16),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: valueScaler(context, 6.0),
                          horizontal: valueScaler(context, 12.0),
                        ),
                        child: Text(
                          'Language',
                          style: TextStyle(
                            fontSize: valueScaler(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      LanguageSection(
                          valueScaler: valueScaler,
                          languageProblemList:
                              widget.userData.languageProblemCount ?? []),
                      const Divider(),
                      Container(
                        padding: EdgeInsets.all(valueScaler(context, 4)),
                        margin: EdgeInsets.only(top: valueScaler(context, 5)),
                        child: Text(
                          'Total problems solved: ${getSolvedCount(widget.userData.problemData)}',
                          style: TextStyle(
                            fontSize: valueScaler(context, 20),
                            color: const Color.fromRGBO(97, 97, 97, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: valueScaler(context, 16),
                      ),
                    ],
                  ),
                ),
              ),
              RecentSubmissionList(
                  valueScaler: valueScaler,
                  submissionList: widget.userData.recentAcSubmissionList ?? []),
            ],
          ),
        ),
      ),
    );
  }
}
