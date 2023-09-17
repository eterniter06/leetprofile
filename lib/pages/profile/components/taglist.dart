import 'package:flutter/material.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

class TagList extends StatelessWidget {
  const TagList({
    super.key,
    required this.skills,
    this.backgroundColor,
    this.borderColor,
  });

  final List<TagsSolved> skills;
  final Color? backgroundColor;
  final Color? borderColor;

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
                    side: BorderSide(
                      color: borderColor ?? Colors.black,
                    ),
                    label: Text(
                        "${skills[index].tagName!} x${skills[index].problemsSolved}"),
                    backgroundColor: backgroundColor,
                  ),
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
