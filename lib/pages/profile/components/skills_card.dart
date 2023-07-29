import 'package:flutter/material.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: const Text('Skills')),
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
        ),
      ),
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
