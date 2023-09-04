import 'package:flutter/material.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import 'taglist.dart';

class SkillsCard extends StatelessWidget {
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
          ),
        if (intermediateSkills!.isNotEmpty)
          TagCard(
            fundamentalSkills: intermediateSkills,
            tagHeader: 'Intermediate',
          ),
        if (advancedSkills!.isNotEmpty)
          TagCard(
            fundamentalSkills: advancedSkills,
            tagHeader: 'Advanced',
          ),
      ],
    );
  }
}

class TagCard extends StatelessWidget {
  const TagCard({
    super.key,
    required this.fundamentalSkills,
    required this.tagHeader,
  });

  final List<TagsSolved>? fundamentalSkills;
  final String tagHeader;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
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
            TagList(skills: fundamentalSkills!),
          ],
        ),
      ),
    );
  }
}
