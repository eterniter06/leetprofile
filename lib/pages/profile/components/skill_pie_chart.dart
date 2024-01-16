import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/providers/theme.dart';

class SkillPieChart extends StatefulWidget {
  const SkillPieChart({
    super.key,
    required this.skills,
    required this.darkSectionTheme,
    required this.lightSectionTheme,
  });

  final List<TagsSolved>? skills;
  final SkillPieSectionThemeData darkSectionTheme, lightSectionTheme;

  @override
  State<SkillPieChart> createState() => _SkillPieChartState();
}

class _SkillPieChartState extends State<SkillPieChart> {
  Color sectionColor(int index) {
    // https://stackoverflow.com/questions/10014271/generate-random-color-distinguishable-to-humans
    // https://en.wikipedia.org/wiki/Golden_angle
    final double goldenAngle = 180 * (3 - sqrt(5));
    final double hue = goldenAngle * index % 360.0;

    SkillPieSectionThemeData theme =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? widget.darkSectionTheme
            : widget.lightSectionTheme;

    return theme.fromASL(hue);
  }

  int touchedSectionIndex = -1;

  double diameter() {
    Size size = MediaQuery.of(context).size;
    return min(size.width, size.height) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: diameter(),
            width: diameter(),
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
                      badgeWidget: touchedSectionIndex == index
                          ? Text(
                              skill.problemsSolved!.toString(),
                              style: const TextStyle(color: Colors.black),
                            )
                          : null,
                      badgePositionPercentageOffset: 0.75,
                      color: sectionColor(index),
                      showTitle: false,
                      title: skill.tagName,
                      radius: diameter() / 2 +
                          (touchedSectionIndex == index ? 8 : 0),
                    );
                  },
                ),
                centerSpaceRadius: 0,
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
                (index) => GestureDetector(
                  onTapDown: (details) => setState(() {
                    touchedSectionIndex = index;
                  }),
                  onTapUp: (TapUpDetails _) => setState(() {
                    touchedSectionIndex = -1;
                  }),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
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
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
