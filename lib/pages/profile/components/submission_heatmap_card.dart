import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import '../../../dataclass/user_class/userdata.dart';

class SubmissionHeatMap extends StatelessWidget {
  const SubmissionHeatMap({super.key, required this.submissionList});

  final List<SubmissionCalendarDate> submissionList;

  @override
  Widget build(BuildContext context) {
    Map<DateTime, int> submissionMap = {
      for (SubmissionCalendarDate submission in submissionList)
        stripHourLevelAndBelowDetails(submission.date!): submission.submissions!
    };

    return ProfileCard(profileHeader: 'Submission Heatmap', children: [
      Center(
        child: HeatMapCalendar(
          colorTipHelper: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Less'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('More'),
            )
          ],
          calendarEndDate: DateTime.now(),
          calendarBeginDate:
              DateTime.now().copyWith(year: DateTime.now().year - 1),
          datasets: submissionMap,
          colorMode: ColorMode.color,
          defaultColor: Colors.grey,
          colorsets: const {
            1: Color(0xffd8ffd8),
            3: Color(0xffbeffbe),
            6: Color(0xffa4ffa4),
            10: Color(0xff47bc47),
            15: Color(0xff5aa85a),
            20: Color(0xff023602),
            30: Color(0xff011b01),
          },
          onClick: (value) {
            DateTime upperBound = DateTime.now();

            if (value.isBefore(upperBound)) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Date: ${value.year}-${value.month}-${value.day}\nSubmissions: ${submissionMap[value]}')));
            }
          },
        ),
      ),
    ]);
  }

  stripHourLevelAndBelowDetails(DateTime dateTime) {
    DateTime strippedDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );

    return strippedDate;
  }
}
