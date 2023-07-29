import 'package:flutter/material.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

class TagList extends StatelessWidget {
  const TagList({
    super.key,
    required this.skills,
  });

  final List<TagsSolved> skills;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int index = 0; index < skills.length; ++index) ...{
                  Chip(
                      label: Text(
                          "${skills[index].tagName!} x${skills[index].problemsSolved}")),
                  if (index != skills.length)
                    const SizedBox(
                      width: 10,
                    )
                }
              ],
            ),
          ),
        ),
      ],
    );
  }
}
