import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

class SkillPieChart extends StatefulWidget {
  const SkillPieChart({super.key, required this.skills});

  final List<TagsSolved>? skills;

  @override
  State<SkillPieChart> createState() => _SkillPieChartState();
}

class _SkillPieChartState extends State<SkillPieChart> {
  Color sectionColor(int index) {
    // https://stackoverflow.com/questions/10014271/generate-random-color-distinguishable-to-humans
    // https://en.wikipedia.org/wiki/Golden_angle
    final double goldenAngle = 180 * (3 - sqrt(5));

    double lightness =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? 0.8
            : 0.75;

    double saturation =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? 1.0
            : 0.65;

    return HSLColor.fromAHSL(
      1.0,
      goldenAngle * index % 360.0,
      saturation,
      lightness,
    ).toColor();
  }

  int touchedSectionIndex = -1;

  final double sectionRadiusDivisor = 4;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            // height: MediaQuery.of(context).size.width / 1.6,
            // width: MediaQuery.of(context).size.width / 1.75,
            height:
                MediaQuery.of(context).size.width / (sectionRadiusDivisor / 2),
            width:
                MediaQuery.of(context).size.width / (sectionRadiusDivisor / 2),
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  // Sourced from the example 1, fl Pie chart
                  touchCallback:
                      (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedSectionIndex = -1;
                        return;
                      }
                      touchedSectionIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                startDegreeOffset: -90,
                sections: List<PieChartSectionData>.generate(
                  widget.skills!.length,
                  (index) {
                    TagsSolved skill = widget.skills![index];
                    return PieChartSectionData(
                      value: skill.problemsSolved!.toDouble(),
                      // badgeWidget: Text(skill.tagName!),
                      // showTitle: true,
                      color: sectionColor(index),
                      showTitle: false,
                      title: skill.tagName,
                      radius: MediaQuery.of(context).size.width /
                          sectionRadiusDivisor,
                      // radius: MediaQuery.of(context).size.width / 3.5,
                    );
                  },
                ),
                centerSpaceRadius: double.infinity,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.skills!.length,
                  (index) => Row(
                    children: [
                      Container(
                        color: sectionColor(index),
                        height: touchedSectionIndex == index ? 10 : 8,
                        width: touchedSectionIndex == index ? 10 : 8,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.skills![index].tagName!,
                        style: TextStyle(
                          color: touchedSectionIndex == index
                              ? sectionColor(index)
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                touchedSectionIndex != -1
                    ? widget.skills![touchedSectionIndex].problemsSolved
                        .toString()
                    : ' ',
                style: TextStyle(color: sectionColor(touchedSectionIndex)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
