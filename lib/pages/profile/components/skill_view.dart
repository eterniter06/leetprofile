import 'package:flutter/material.dart';
import 'package:ui_elements/database/settings_database.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/components/extensible_animated_wrap.dart';
import 'package:ui_elements/pages/profile/components/skill_pie_chart.dart';
import 'package:ui_elements/providers/theme.dart';

class SkillView extends StatelessWidget {
  const SkillView({
    super.key,
    required this.showPieChart,
    required this.pieSectionDarkTheme,
    required this.pieSectionLightTheme,
    required this.skills,
    required this.skillChipTheme,
  });

  final List<TagsSolved> skills;
  final bool showPieChart;
  final SkillChipTheme skillChipTheme;
  final SkillPieSectionThemeData pieSectionDarkTheme, pieSectionLightTheme;

  @override
  Widget build(BuildContext context) {
    return showPieChart
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0),
            child: SkillPieChart(
              skills: skills,
              darkSectionTheme: pieSectionDarkTheme,
              lightSectionTheme: pieSectionLightTheme,
            ),
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
