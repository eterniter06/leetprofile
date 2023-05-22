import 'package:flutter/material.dart';

import 'dataclass/user_class/userdata.dart';
import 'recent_submission_card.dart';

class RecentSubmissionList extends StatefulWidget {
  const RecentSubmissionList(
      {super.key, required this.submissionList, required this.valueScaler});
  final List<RecentSubmission> submissionList;
  final Function valueScaler;
  @override
  State<RecentSubmissionList> createState() => _RecentSubmissionListState();
}

class _RecentSubmissionListState extends State<RecentSubmissionList> {
  @override
  Widget build(BuildContext context) {
    return widget.submissionList.isEmpty
        ? Card(
            child: Padding(
              padding: EdgeInsets.all(widget.valueScaler(context, 8.0)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(widget.valueScaler(context, 8.0)),
                  child: const Text(
                    'No Recent Submissions',
                  ),
                ),
              ),
            ),
          )
        : Card(
            child: Padding(
              padding: EdgeInsets.all(widget.valueScaler(context, 8.0)),
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
                    itemBuilder: (context, index) => RecentSubmissionCard(
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
