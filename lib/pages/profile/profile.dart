import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_elements/providers/user_list.dart';

import 'package:ui_elements/database/settings_database.dart';
import 'package:ui_elements/database/user_database.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'package:ui_elements/common_components/widgets/refresh_icon_button.dart';

import 'components/badge_card.dart';
import 'components/basic_user_info_card.dart';
import 'components/contests_card.dart';
import 'components/language_section.dart';
import 'components/recent_submission_card.dart';
import 'components/skill_card.dart';
import 'components/solved_problem_card.dart';
import 'components/submission_heatmap_card.dart';
import 'components/nickname_dialog.dart';

// Todo: Separate into 2 classes
class ProfilePage extends StatefulWidget {
  final UserData userData;
  final Widget? refreshIconButton;
  final GlobalKey<RefreshIconButtonState>? refreshIconKey;
  final bool isReorderable;

  const ProfilePage(
      {super.key,
      required this.userData,
      this.refreshIconButton,
      this.refreshIconKey})
      : isReorderable = false;

  const ProfilePage.reorderableAbsorbPointer(
      {super.key, required this.userData})
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
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  List<String> profileComponentListAsString = [];

  bool isRefreshing = false;

  List<Widget> profileComponentList = [];
  Map<String, Widget?> componentMapper = {};

  late UserData userData = widget.userData;
  late AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    // Assigning _defaultOrdering directly leads to assigning const to non-const
    profileComponentListAsString = SettingsDatabase.profileComponentOrder() ??
        widget._defaultOrdering.toList();

    _controller = widget.isReorderable
        ? AnimationController(
            upperBound: 1.025,
            lowerBound: 1,
            vsync: this,
            duration: const Duration(milliseconds: 300),
          )
        : null;

    componentMapper = initMap();
    profileComponentList = initWidgetList();
  }

  @override
  void dispose() {
    _controller?.dispose();

    // Since status bar is only not shown for the profile view
    // All other pages show the status bar at all times
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );

    super.dispose();
  }

  List<Widget> initWidgetList() {
    List<Widget> list = [];

    for (String componentName in profileComponentListAsString) {
      Widget? widget = componentMapper[componentName];

      if (widget == null) {
        continue;
      }

      list.add(widget);
    }
    return list;
  }

  Map<String, Widget?> initMap() {
    Map<String, Widget?> map = {};

    map['BasicUserInfo'] = BasicInfoExp(
      userData: userData,
      key: UniqueKey(),
    );

    map['SolvedProblemsCard'] = SolvedProblemsCard(
      problemData: userData.problemData,
      key: UniqueKey(),
    );

    map['SubmissionHeatMap'] = userData.submissionActivity != null &&
            userData.submissionActivity!.isNotEmpty
        ? SubmissionHeatMap(
            submissionList: userData.submissionActivity!,
            key: UniqueKey(),
          )
        : null;

    map['ContestCard'] = userData.userContestRanking != null
        ? ContestCard(
            contests: userData.userContestRankingHistory!,
            overallContestData: userData.userContestRanking!,
            key: UniqueKey(),
          )
        : null;

    map['SkillsCard'] = hasSkills()
        ? SkillCard(
            fundamentalSkills: userData.fundamentalTags,
            intermediateSkills: userData.intermediateTags,
            advancedSkills: userData.advancedTags,
            key: UniqueKey(),
          )
        : null;

    map['LanguageSection'] = hasSolvedProblems()
        ? LanguageSection(
            languageProblemList: userData.languageProblemCount!,
            key: UniqueKey(),
          )
        : null;

    map['BadgeCard'] = userData.badges != null && userData.badges!.isNotEmpty
        ? BadgeCard(
            badges: userData.badges!,
            key: UniqueKey(),
          )
        : null;

    map['RecentSubmissionCard'] = widget.isReorderable
        ? RecentSubmissionCardAbsorbPointer(
            submissionList: UserData.dummyUser.recentAcSubmissionList!)
        : RecentSubmissionCard(
            submissionList: userData.recentAcSubmissionList ?? [],
            key: UniqueKey(),
          );

    // Prevent interacting with the components when reordering
    if (widget.isReorderable) {
      map.forEach((key, value) {
        map[key] = AbsorbPointer(
          key: UniqueKey(),
          child: value,
        );
      });
    }

    return map;
  }

  Future<void> _refreshUserImpl() async {
    if (mounted) {
      await Provider.of<UserListModel>(context, listen: false)
          .updateUser(userData);
    }
    setState(() {
      userData = Provider.of<UserListModel>(context, listen: false)
              .findUserFromUsername(userData.username) ??
          userData;
      componentMapper = initMap();
      profileComponentList = initWidgetList();
    });

    // print(Time.dateLong(userData.lastFetchTime.toString()));
  }

  bool hasSkills() {
    return (userData.fundamentalTags?.isNotEmpty)! ||
        (userData.intermediateTags?.isNotEmpty)! ||
        (userData.advancedTags?.isNotEmpty)!;
  }

  bool hasSolvedProblems() {
    var problems = userData.languageProblemCount;

    if (problems == null || problems.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              title: Text(userData.nickname ??
                  (userData.realname == ""
                      ? userData.username
                      : userData.realname)),
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
                                  oldNickname: userData.nickname,
                                  realname: userData.realname,
                                  username: userData.username,
                                ),
                              );

                              if (newNickname == null) {
                                return;
                              }

                              setState(() {
                                userData.updateNickname(newNickname);
                              });

                              await UserDatabase.put(userData);
                            }),
                      ),
                      RefreshIconButton(
                        globalKey: widget.refreshIconKey,
                        tooltip: 'Refresh user',
                        task: () async {
                          await _refreshUserImpl();
                        },
                        postHook: () async {
                          await UserDatabase.put(userData);
                          if (mounted) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('User profile has been refreshed.'),
                              ),
                            );
                          }
                        },
                      ),
                      IconButton(
                        tooltip: 'Share leetcode profile',
                        icon: const Icon(Icons.share),
                        onPressed: () => Share.share(
                            'https://leetcode.com/${userData.username}'),
                      ),
                    ],
            )
          : null,
      floatingActionButton: widget.isReorderable
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.save),
              label: const Text('Save'),
              tooltip: 'Save layout',
              onPressed: () =>
                  Navigator.of(context).pop(profileComponentListAsString),
            )
          : null,
      body: widget.isReorderable
          ? ReorderableListView(
              proxyDecorator: (child, index, animation) => ScaleTransition(
                scale: Tween<double>(begin: 1, end: 1.025).animate(
                  CurvedAnimation(
                    parent: _controller!,
                    curve: Curves.linear,
                  ),
                ),
                child: profileComponentList[index],
              ),
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
              onReorderStart: (index) => HapticFeedback.lightImpact(),
              children: [
                for (int index = 0;
                    index < profileComponentList.length;
                    ++index)
                  profileComponentList[index],
              ],
            )
          : OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  // SystemChrome.setEnabledSystemUIMode(
                  //   SystemUiMode.edgeToEdge,
                  //   overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
                  // );
                  return ListView.builder(
                    itemBuilder: (context, index) =>
                        profileComponentList[index],
                    itemCount: profileComponentList.length,
                  );
                } else {
                  // SystemChrome.setEnabledSystemUIMode(
                  //   SystemUiMode.manual,
                  //   overlays: [SystemUiOverlay.bottom],
                  // );
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        title: Text(userData.nickname ??
                            (userData.realname == ""
                                ? userData.username
                                : userData.realname)),
                        actions: widget.isReorderable
                            ? null
                            : [
                                Consumer<UserListModel>(
                                  builder: (context, userListModel, child) =>
                                      IconButton(
                                          icon: const Icon(Icons.edit),
                                          tooltip: 'Edit nickname',
                                          onPressed: () async {
                                            String? newNickname =
                                                await showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  NicknameInputDialog(
                                                oldNickname: userData.nickname,
                                                realname: userData.realname,
                                                username: userData.username,
                                              ),
                                            );

                                            if (newNickname == null) {
                                              return;
                                            }

                                            setState(() {
                                              userData
                                                  .updateNickname(newNickname);
                                            });

                                            await UserDatabase.put(userData);
                                          }),
                                ),
                                RefreshIconButton(
                                  globalKey: widget.refreshIconKey,
                                  tooltip: 'Refresh user',
                                  task: () async {
                                    await _refreshUserImpl();
                                  },
                                  postHook: () async {
                                    await UserDatabase.put(userData);
                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .removeCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'User profile has been refreshed.'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                  tooltip: 'Share leetcode profile',
                                  icon: const Icon(Icons.share),
                                  onPressed: () => Share.share(
                                      'https://leetcode.com/${userData.username}'),
                                ),
                              ],
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => profileComponentList[index],
                          childCount: profileComponentList.length,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
    );
  }
}
