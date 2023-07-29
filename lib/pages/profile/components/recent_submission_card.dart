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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                shape: const Border(),
                initiallyExpanded: false,
                title: const Text(
                  'Recent Submissions',
                ),
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.submissionList.length,
                    itemBuilder: (context, index) => RecentSubmissionTile(
                        submission: widget.submissionList[index]),
                    separatorBuilder: (context, index) => const Divider(
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
