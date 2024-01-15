import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ui_elements/providers/theme.dart';
import 'package:ui_elements/database/settings_database.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/common_components/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import 'extensible_animated_wrap.dart';

class SkillCard extends StatefulWidget implements ClassName {
  const SkillCard({
    super.key,
    this.fundamentalSkills,
    this.intermediateSkills,
    this.advancedSkills,
  });

  final List<TagsSolved>? fundamentalSkills, intermediateSkills, advancedSkills;

  @override
  State<SkillCard> createState() => _SkillCardState();

  @override
  String className() {
    return 'SkillsCard';
  }
}

class _SkillCardState extends State<SkillCard> {
  bool showPieChart = false;

  void toggleViews() {
    setState(() {
      showPieChart = !showPieChart;
    });
  }

  bool skillCategoryExists(List<TagsSolved>? skills) {
    return skills != null && skills.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      // Can't use content padding because pie chart is too big
      // Set padding individually for required components for this Card
      trailer: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) => RotationTransition(
            turns: showPieChart
                ? Tween<double>(begin: 0, end: 2.0).animate(animation)
                : Tween<double>(begin: 2.0, end: 0).animate(animation),
            child: ScaleTransition(scale: animation, child: child),
          ),
          child: showPieChart
              ? Icon(
                  Icons.category_rounded,
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  key: const ValueKey('SkillCardTrailerViewToggle1'),
                )
              : Icon(
                  Icons.pie_chart,
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  key: const ValueKey('SkillCardTrailerViewToggle2'),
                ),
        ),
        tooltip: 'Toggle between chips and pie chart',
        onPressed: () => toggleViews(),
      ),
      header: 'Skills',
      children: [
        if (skillCategoryExists(widget.fundamentalSkills)) ...{
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Fundamental',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SkillView(
            showPieChart: showPieChart,
            skillChipTheme: fundamentalSkillChipTheme,
            skills: widget.fundamentalSkills!,
          ),
        },
        if (skillCategoryExists(widget.intermediateSkills)) ...{
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Intermediate',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SkillView(
            showPieChart: showPieChart,
            skillChipTheme: intermediateSkillChipTheme,
            skills: widget.intermediateSkills!,
          )
        },
        if (skillCategoryExists(widget.advancedSkills)) ...{
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Advanced',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SkillView(
            showPieChart: showPieChart,
            skillChipTheme: advancedSkillChipTheme,
            skills: widget.advancedSkills!,
          )
        },
      ],
    );
  }
}

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

class SkillView extends StatelessWidget {
  const SkillView({
    super.key,
    required this.showPieChart,
    required this.skills,
    required this.skillChipTheme,
  });

  final List<TagsSolved> skills;
  final bool showPieChart;
  final SkillChipTheme skillChipTheme;

  @override
  Widget build(BuildContext context) {
    return showPieChart
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0),
            child: SkillPieChart(skills: skills),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ExtensibleAnimatedWrap(
              defaultItemCount: SettingsDatabase.numberOfShownTags(),
              spacing: 8,
              children: List.generate(skills.length, (index) {
                return Chip(
                  label: Text(
                      "${skills[index].tagName!} x${skills[index].problemsSolved}"),
                  backgroundColor: skillChipTheme.backgroundColor,
                  labelStyle: skillChipTheme.labelStyle,
                  side: skillChipTheme.side,
                );
              }),
            ),
          );
  }
}

class SkillChipTheme {
  BorderSide? side;
  TextStyle? labelStyle;
  Color? backgroundColor;

  SkillChipTheme({this.side, this.labelStyle, this.backgroundColor});
}

SkillChipTheme fundamentalSkillChipTheme = SkillChipTheme(
  side: const BorderSide(
    color: ThemeModeModel.fundamentalBorder,
  ),
  labelStyle: TextStyle(
    color: ThemeModeModel.getInverseBW(ThemeModeModel.fundamentalBackground),
  ),
  backgroundColor: ThemeModeModel.fundamentalBackground,
);

SkillChipTheme intermediateSkillChipTheme = SkillChipTheme(
  side: const BorderSide(
    color: ThemeModeModel.intermediateBorder,
  ),
  labelStyle: TextStyle(
    color: ThemeModeModel.getInverseBW(ThemeModeModel.intermediateBackground),
  ),
  backgroundColor: ThemeModeModel.intermediateBackground,
);

SkillChipTheme advancedSkillChipTheme = SkillChipTheme(
  side: const BorderSide(
    color: ThemeModeModel.advancedBorder,
  ),
  labelStyle: TextStyle(
    color: ThemeModeModel.getInverseBW(ThemeModeModel.advancedBackground),
  ),
  backgroundColor: ThemeModeModel.advancedBackground,
);
