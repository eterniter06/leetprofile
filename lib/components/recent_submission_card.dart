import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dataclass/user_class/userdata.dart';

class RecentSubmissionCard extends StatelessWidget {
  const RecentSubmissionCard({super.key, required this.submission});
  final RecentSubmission submission;

  String getOrdinal(DateTime submissionTime) {
    final day = int.parse(DateFormat('dd').format(submissionTime));
    if (day >= 10 && day <= 20) return "th";

    return day % 10 == 1
        ? "st"
        : day % 10 == 2
            ? "nd"
            : day % 10 == 3
                ? "rd"
                : "th";
  }

  String getTimeFromEpochsInSeconds() {
    final submissionTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(submission.timestamp!) * Duration.millisecondsPerSecond)
        .toLocal();

    final ordinal = getOrdinal(submissionTime);
    final dateTimeFormatter = DateFormat("dd'$ordinal' MMMM yyyy HH:mm:ss");

    return dateTimeFormatter.format(submissionTime);
  }

  String getTimeOfDay() {
    final submissionTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(submission.timestamp!) * Duration.millisecondsPerSecond)
        .toLocal();

    return DateFormat("HH:mm:ss").format(submissionTime);
  }

  String getDay() {
    final submissionTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(submission.timestamp!) * Duration.millisecondsPerSecond)
        .toLocal();

    final ordinal = getOrdinal(submissionTime);
    final dateTimeFormatter = DateFormat("dd'$ordinal' MMMM yyyy");

    return dateTimeFormatter.format(submissionTime);
  }

  Future<void> _launchQuestionUrl() async {
    Uri questionLink =
        Uri.parse('https://leetcode.com/problems/${submission.titleSlug}');

    if (await canLaunchUrl(questionLink)) {
      await launchUrl(questionLink, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not open Question url');
    }
  }

  Future<void> _launchSubmissionUrl() async {
    Uri questionLink =
        Uri.parse('https://leetcode.com/submissions/detail/${submission.id}');

    if (await canLaunchUrl(questionLink)) {
      await launchUrl(questionLink, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not open Question url');
    }
  }

  // void _launchQuestionMenu() {
  //   DropdownButton(
  //     items: [
  //       Text('Copy Question URL'),

  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _launchQuestionUrl(),
        // onLongPress: () => _launchQuestionMenu(),
        child: ListTile(
          leading: IconButton(
            splashRadius: 30,
            icon: const Icon(Icons.question_answer),
            onPressed: () async {
              await _launchSubmissionUrl();
            },
          ),

          /* Refer to: 
          *  https://github.com/flutter/flutter/issues/53797
          *  for why the question title isn't copyable
          */
          title: Text(
            submission.title!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(getTimeOfDay()),
          subtitle: Text(getDay()),
        ),
      ),
    );
  }
}
