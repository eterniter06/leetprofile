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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: const Text('Skills')),
            if (fundamentalSkills!.isNotEmpty) ...{
              TagList(skills: fundamentalSkills!, tagHeader: 'Fundamental'),
              // const SizedBox(height: 5),
            },
            if (intermediateSkills!.isNotEmpty) ...{
              TagList(skills: intermediateSkills!, tagHeader: 'Intermediate'),
              // const SizedBox(height: 5),
            },
            if (advancedSkills!.isNotEmpty) ...{
              TagList(skills: advancedSkills!, tagHeader: 'Advanced'),
            },
          ],
        ),
      ),
    );
  }
}
