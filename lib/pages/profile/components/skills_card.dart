import 'package:flutter/material.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import 'taglist.dart';

class SkillsCard extends StatelessWidget implements ClassName {
  const SkillsCard({
    super.key,
    this.fundamentalSkills,
    this.intermediateSkills,
    this.advancedSkills,
  });

  final List<TagsSolved>? fundamentalSkills, intermediateSkills, advancedSkills;

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      profileHeader: 'Skills',
      children: [
        if (fundamentalSkills!.isNotEmpty)
          TagCard(
            fundamentalSkills: fundamentalSkills,
            tagHeader: 'Fundamental',
            backgroundColor: const Color.fromARGB(255, 247, 251, 255),
            borderColor: const Color.fromARGB(255, 219, 237, 253),
          ),
        if (intermediateSkills!.isNotEmpty) ...{
          const SizedBox(height: 10),
          TagCard(
            fundamentalSkills: intermediateSkills,
            tagHeader: 'Intermediate',
            backgroundColor: const Color.fromARGB(255, 238, 248, 255),
            borderColor: const Color.fromARGB(255, 201, 231, 255),
          ),
        },
        if (advancedSkills!.isNotEmpty) ...{
          const SizedBox(height: 10),
          TagCard(
            fundamentalSkills: advancedSkills,
            tagHeader: 'Advanced',
            backgroundColor: const Color.fromARGB(255, 223, 241, 255),
            borderColor: Colors.blue.shade200,
          ),
        }
      ],
    );
  }

  @override
  String className() {
    return 'SkillsCard';
  }
}

class TagCard extends StatelessWidget {
  const TagCard({
    super.key,
    required this.fundamentalSkills,
    required this.tagHeader,
    this.backgroundColor,
    this.borderColor,
  });

  final List<TagsSolved>? fundamentalSkills;
  final String tagHeader;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        bottom: 4.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(tagHeader),
          ),
          TagList(
            skills: fundamentalSkills!,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
          ),
        ],
      ),
    );
  }
}
