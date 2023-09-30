import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:intl/intl.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

class SubmissionHeatMap extends StatelessWidget implements ClassName {
  const SubmissionHeatMap({super.key, required this.submissionList});

  final List<SubmissionCalendarDate> submissionList;

  @override
  Widget build(BuildContext context) {
    Map<DateTime, int> submissionMap = {
      for (SubmissionCalendarDate submission in submissionList)
        stripHourLevelAndBelowDetails(submission.date!): submission.submissions!
    };

    return ProfileCard(
      profileHeader: 'Submission Heatmap',
      children: [
        Center(
          child: HeatMapCalendar(
            leadingColorTipHelper: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Less'),
            ),
            trailingColorTipHelper: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('More'),
            ),
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
            contrastingTextColor: true,
            onTapDown: (date, tapDetails) {
              DateTime now = DateTime.now();

              DateTime upperBound =
                  stripHourLevelAndBelowDetails(now).copyWith(day: now.day + 1);

              DateTime lowerBound = stripHourLevelAndBelowDetails(now)
                  .copyWith(year: now.year - 1)
                  .add(const Duration(days: -1));

              DateFormat format = DateFormat("d MMM, yyyy");

              if (date.isBefore(upperBound) && date.isAfter(lowerBound)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(days: 1),
                    content: Text(
                        'Submissions: ${submissionMap[date]}\nDate: ${format.format(date)}')));
              }
            },
            onTapUp: (date, tapDetails) {
              Future.delayed(const Duration(milliseconds: 700)).then(
                (value) => ScaffoldMessenger.of(context).clearSnackBars(),
              );
            },
          ),
        ),
      ],
    );
  }

  DateTime stripHourLevelAndBelowDetails(DateTime dateTime) {
    DateTime strippedDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );

    return strippedDate;
  }

  @override
  String className() {
    return 'SubmissionHeatMap';
  }
}
