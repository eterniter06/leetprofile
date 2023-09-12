import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_elements/database/settings_database.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import '../../../interfaces.dart';
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

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      profileHeader: widget.submissionList.isEmpty
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
                      child: expanded == false
                          ? recentSubmissionsShownUnexpanded == 0
                              ? const Text('Expand submissions')
                              : const Text('Show more submissions')
                          : const Text('Collapse list'),
                    ),
                  ),
                )
              }
            ],

      // Card(
      //     child: ExpansionTile(
      //       onExpansionChanged: (value) {
      //         if (expanded != value) {
      //           setState(() {
      //             expanded = value;
      //           });
      //         }
      //       },
      //       tilePadding: const EdgeInsets.only(left: 4, right: 20),
      //       childrenPadding: const EdgeInsets.symmetric(horizontal: 4),
      //       shape: const Border(),
      //       initiallyExpanded: false,
      //       title: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const Padding(
      //             padding:
      //                 EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      //             child: Text(
      //               'Recent Submissions',
      //             ),
      //           ),
      //           RecentSubmissionTile(submission: widget.submissionList[0]),
      //           if (expanded)
      //             const Divider(
      //               height: 0,
      //             ),
      //         ],
      //       ),
      //       children: [
      //         ListView.separated(
      //           physics: const NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           itemCount: widget.submissionList.length - 1,
      //           itemBuilder: (context, index) => RecentSubmissionTile(
      //               submission: widget.submissionList[index + 1]),
      //           separatorBuilder: (context, index) => const Divider(
      //             height: 0,
      //           ),
      //         ),
      //       ],
      //     ),
    );
  }
}
