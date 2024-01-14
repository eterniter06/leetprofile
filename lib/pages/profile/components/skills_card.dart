import 'package:flutter/material.dart';
import 'package:ui_elements/providers/theme.dart';
import 'package:ui_elements/database/settings_database.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/common_components/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import 'extensible_animated_wrap.dart';

class SkillsCard extends StatefulWidget implements ClassName {
  const SkillsCard({
    super.key,
    this.fundamentalSkills,
    this.intermediateSkills,
    this.advancedSkills,
  });

  final List<TagsSolved>? fundamentalSkills, intermediateSkills, advancedSkills;

  @override
  State<SkillsCard> createState() => _SkillsCardState();

  @override
  String className() {
    return 'SkillsCard';
  }
}

class _SkillsCardState extends State<SkillsCard> {
  late int minTags;
  List<Widget> intermediateWidgets = [];
  List<Widget> fundamentalWidgets = [];
  List<Widget> advancedWidgets = [];

  @override
  void initState() {
    super.initState();

    minTags = SettingsDatabase.numberOfShownTags();

    if (widget.fundamentalSkills!.isNotEmpty) {
      for (TagsSolved skill in widget.fundamentalSkills!) {
        Chip fundamentalSkillChip = Chip(
          side: const BorderSide(
            color: ThemeModeModel.fundamentalBorder,
          ),
          label: Text("${skill.tagName!} x${skill.problemsSolved}"),
          labelStyle: TextStyle(
            color: ThemeModeModel.getInverseBW(
                ThemeModeModel.fundamentalBackground),
          ),
          backgroundColor: ThemeModeModel.fundamentalBackground,
        );
        fundamentalWidgets.add(fundamentalSkillChip);
      }
    }

    if (widget.intermediateSkills!.isNotEmpty) {
      for (TagsSolved skill in widget.intermediateSkills!) {
        Chip intermediateSkillChip = Chip(
          side: const BorderSide(
            color: ThemeModeModel.intermediateBorder,
          ),
          label: Text("${skill.tagName!} x${skill.problemsSolved}"),
          labelStyle: TextStyle(
            color: ThemeModeModel.getInverseBW(
                ThemeModeModel.intermediateBackground),
          ),
          backgroundColor: ThemeModeModel.intermediateBackground,
        );
        intermediateWidgets.add(intermediateSkillChip);
      }
    }

    if (widget.advancedSkills!.isNotEmpty) {
      for (TagsSolved skill in widget.advancedSkills!) {
        Chip advancedSkillChip = Chip(
          side: const BorderSide(
            color: ThemeModeModel.advancedBorder,
          ),
          label: Text("${skill.tagName!} x${skill.problemsSolved}"),
          labelStyle: TextStyle(
            color:
                ThemeModeModel.getInverseBW(ThemeModeModel.advancedBackground),
          ),
          backgroundColor: ThemeModeModel.advancedBackground,
        );
        advancedWidgets.add(advancedSkillChip);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      contentPadding: const EdgeInsets.only(
        left: 8.0,
      ),
      header: 'Skills',
      children: [
        if (fundamentalWidgets.isNotEmpty) ...{
          const Text(
            'Fundamental',
            style: TextStyle(fontSize: 16),
          ),
          ExtensibleAnimatedWrap(
            defaultItemCount: minTags,
            spacing: 8,
            children: fundamentalWidgets,
          ),
        },
        if (intermediateWidgets.isNotEmpty) ...{
          const SizedBox(height: 40),
          const Text(
            'Intermediate',
            style: TextStyle(fontSize: 16),
          ),
          ExtensibleAnimatedWrap(
            defaultItemCount: minTags,
            spacing: 8,
            children: intermediateWidgets,
          ),
        },
        if (advancedWidgets.isNotEmpty) ...{
          const SizedBox(height: 40),
          const Text(
            'Advanced',
            style: TextStyle(fontSize: 16),
          ),
          ExtensibleAnimatedWrap(
            spacing: 8,
            defaultItemCount: minTags,
            children: advancedWidgets,
          ),
        },
      ],
    );
  }
}
