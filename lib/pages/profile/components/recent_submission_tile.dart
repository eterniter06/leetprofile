import 'package:flutter/material.dart';

import 'package:ui_elements/time.dart';

import 'package:ui_elements/providers/theme.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class RecentSubmissionTile extends StatelessWidget {
  const RecentSubmissionTile({super.key, required this.submission});
  final RecentSubmission submission;

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
    return Tooltip(
      message: 'Visit question',
      child: InkWell(
        onTap: () => _launchQuestionUrl(),
        child: ListTile(
          leading: Material(
            elevation: 1,
            shape: const CircleBorder(),
            child: IconButton(
              tooltip: 'View user submission',
              icon: const Icon(Icons.question_answer),
              onPressed: () async {
                if (await Vibration.hasVibrator() ?? false) {
                  Vibration.vibrate(duration: 10);
                }
                await _launchSubmissionUrl();
              },
            ),
          ),

          /* Refer to: 
          *  https://github.com/flutter/flutter/issues/53797
          *  for why the question title isn't copyable
          */
          title: Text(
            submission.title!,
          ),
          trailing: Text(Time.timeOfDay(submission.timestamp!)),
          subtitle: Text(
            Time.dateLong(submission.timestamp!),
            style: const TextStyle(
              fontSize: 12,
              inherit: true,
              color: ThemeModeModel.lightSecondaryInverse,
            ),
          ),
        ),
      ),
    );
  }
}
