import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_elements/database/settings_database.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import '../../../common_components/interfaces.dart';
import 'recent_submission_tile.dart';

class RecentSubmissionCard extends StatefulWidget implements ClassName {
  const RecentSubmissionCard({super.key, required this.submissionList});
  final List<RecentSubmission> submissionList;

  @override
  State<RecentSubmissionCard> createState() => _RecentSubmissionCardState();

  @override
  String className() {
    return 'RecentSubmissionCard';
  }
}

class _RecentSubmissionCardState extends State<RecentSubmissionCard>
    with TickerProviderStateMixin {
  bool expanded = false;
  late int recentSubmissionsShownUnexpanded;
  late bool moreEntries;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    recentSubmissionsShownUnexpanded = min(widget.submissionList.length,
        SettingsDatabase.numberOfShownUserSubmissions());
    moreEntries =
        recentSubmissionsShownUnexpanded < widget.submissionList.length;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> showMoreItems() async {
    setState(() {
      expanded = true;
    });
    await _controller.forward();
  }

  Future<void> collapseList() async {
    setState(() {
      expanded = false;
    });
    await _controller.reverse();
  }

  void expandOrCollapse() {
    expanded == false ? showMoreItems() : collapseList();
  }

  Text expandOrCollapseText() {
    if (expanded == true) return const Text('Collapse list');

    return recentSubmissionsShownUnexpanded == 0
        ? const Text('Expand submissions')
        : const Text('Show more submissions');
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      header: widget.submissionList.isEmpty
          ? 'No Recent Submissions'
          : 'Recent Submissions',
      children: widget.submissionList.isEmpty
          ? null
          : [
              for (int index = 0;
                  index < recentSubmissionsShownUnexpanded;
                  ++index)
                RecentSubmissionTile(submission: widget.submissionList[index]),
              if (moreEntries) ...{
                SizeTransition(
                  sizeFactor: _animation,
                  child: Column(
                    children: [
                      for (int index = recentSubmissionsShownUnexpanded;
                          index < widget.submissionList.length;
                          ++index)
                        RecentSubmissionTile(
                          submission: widget.submissionList[index],
                        )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => expandOrCollapse(),
                  child: ListTile(
                    trailing: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.5).animate(_animation),
                      child: IconButton(
                        icon: const Icon(Icons.expand_more),
                        onPressed: () => expandOrCollapse(),
                      ),
                    ),
                    title: Center(
                      child: expandOrCollapseText(),
                    ),
                  ),
                )
              }
            ],
    );
  }
}

class RecentSubmissionCardAbsorbPointer extends StatelessWidget
    implements ClassName {
  const RecentSubmissionCardAbsorbPointer({
    super.key,
    required this.submissionList,
  });

  final List<RecentSubmission> submissionList;

  @override
  String className() {
    return 'RecentSubmissionCard';
  }

  @override
  Widget build(BuildContext context) {
    int recentSubmissionsShownUnexpanded = min(
        submissionList.length, SettingsDatabase.numberOfShownUserSubmissions());
    bool moreEntries = recentSubmissionsShownUnexpanded < submissionList.length;

    return ProfileCard(
      header: submissionList.isEmpty
          ? 'No Recent Submissions'
          : 'Recent Submissions',
      children: submissionList.isEmpty
          ? null
          : [
              for (int index = 0;
                  index < recentSubmissionsShownUnexpanded;
                  ++index)
                RecentSubmissionTile(submission: submissionList[index]),
              if (moreEntries) ...{
                ListTile(
                  trailing: const Icon(
                    Icons.expand_more,
                  ),
                  title: Center(
                    child: recentSubmissionsShownUnexpanded == 0
                        ? const Text('Expand submissions')
                        : const Text('Show more submissions'),
                  ),
                )
              }
            ],
    );
  }
}
