import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'recent_submission_tile.dart';

class RecentSubmissionCard extends StatefulWidget {
  const RecentSubmissionCard({super.key, required this.submissionList});
  final List<RecentSubmission> submissionList;
  @override
  State<RecentSubmissionCard> createState() => _RecentSubmissionCardState();
}

class _RecentSubmissionCardState extends State<RecentSubmissionCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return widget.submissionList.isEmpty
        ? Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'No Recent Submissions',
                  ),
                ),
              ),
            ),
          )
        : Card(
            child: ExpansionTile(
              onExpansionChanged: (value) {
                if (expanded != value) {
                  setState(() {
                    expanded = value;
                  });
                }
              },
              tilePadding: const EdgeInsets.only(left: 4, right: 20),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 4),
              shape: const Border(),
              initiallyExpanded: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                    child: Text(
                      'Recent Submissions',
                    ),
                  ),
                  RecentSubmissionTile(submission: widget.submissionList[0]),
                  if (expanded)
                    const Divider(
                      height: 0,
                    ),
                ],
              ),
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.submissionList.length - 1,
                  itemBuilder: (context, index) => RecentSubmissionTile(
                      submission: widget.submissionList[index + 1]),
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                  ),
                ),
              ],
            ),
          );
  }
}
