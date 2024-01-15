import 'package:flutter/material.dart';
import 'package:ui_elements/pages/profile/components/skill_view.dart';
import 'package:ui_elements/providers/theme.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/common_components/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

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
            skillChipTheme: ThemeModeModel.fundamentalSkillChipTheme,
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
            skillChipTheme: ThemeModeModel.intermediateSkillChipTheme,
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
            skillChipTheme: ThemeModeModel.advancedSkillChipTheme,
            skills: widget.advancedSkills!,
          )
        },
      ],
    );
  }
}
