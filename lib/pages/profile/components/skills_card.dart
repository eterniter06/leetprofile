import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ui_elements/change_notifiers/theme.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import 'taglist.dart';

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
  int minTags = 4;
  late int tagsToShow;
  List<Widget> intermediateWidgets = [];
  late int intermediateLength;

  @override
  void initState() {
    super.initState();
    tagsToShow = minTags;

    if (widget.intermediateSkills!.isNotEmpty) {
      for (int i = 0;
          i < min(widget.intermediateSkills!.length, tagsToShow);
          ++i) {
        intermediateWidgets.add(Chip(
          side: const BorderSide(
            color: Color.fromARGB(255, 201, 231, 255),
          ),
          label: Text(
              "${widget.intermediateSkills![i].tagName!} x${widget.intermediateSkills![i].problemsSolved}"),
          backgroundColor: const Color.fromARGB(255, 238, 248, 255),
        ));
        intermediateWidgets.add(SizedBox(width: 8));
      }
    }

    intermediateLength = intermediateWidgets.length - 1;

    intermediateWidgets.add(ActionChip(
      elevation: 2,
      backgroundColor: tagsToShow < widget.intermediateSkills!.length
          ? ThemeModeModel.lightSecondary
          : ThemeModeModel.lightBackground,
      side: BorderSide(
          color: tagsToShow < widget.intermediateSkills!.length
              ? ThemeModeModel.lightPrimary
              : const Color.fromARGB(255, 255, 233, 199)),
      onPressed: () {
        intermediateLength / 2 == widget.intermediateSkills?.length
            ? removeItems(intermediateWidgets)
            : addItems(intermediateWidgets, widget.intermediateSkills!);

        print(
            '${widget.intermediateSkills!.length} : ${intermediateLength / 2}');
      },
      label: intermediateLength / 2 == widget.intermediateSkills?.length
          ? const Text('Show less')
          : const Text('Show more'),
    ));
  }

  void test() {
    setState(() {
      intermediateWidgets.insert(
          6,
          Chip(
            side: const BorderSide(
              color: Color.fromARGB(255, 201, 231, 255),
            ),
            label: Text(
                "${widget.intermediateSkills![0].tagName!} x${widget.intermediateSkills![0].problemsSolved}"),
            backgroundColor: const Color.fromARGB(255, 238, 248, 255),
          ));
    });
  }

  void addItems(List<Widget> widgets, List<TagsSolved> tagLevel) {
    setState(() {
      intermediateWidgets.removeLast();
      for (int itemIndex = widgets.length ~/ 2;
          itemIndex < tagLevel.length;
          ++itemIndex) {
        intermediateWidgets.add(Chip(
          side: const BorderSide(
            color: Color.fromARGB(255, 201, 231, 255),
          ),
          label: Text(
              "${tagLevel[itemIndex].tagName!} x${tagLevel[itemIndex].problemsSolved}"),
          backgroundColor: const Color.fromARGB(255, 238, 248, 255),
        ));
        intermediateWidgets.add(SizedBox(width: 8));
      }

      intermediateLength = intermediateWidgets.length;

      intermediateWidgets.add(ActionChip(
        elevation: 2,
        backgroundColor: tagsToShow < widget.intermediateSkills!.length
            ? ThemeModeModel.lightSecondary
            : ThemeModeModel.lightBackground,
        side: BorderSide(
            color: tagsToShow < widget.intermediateSkills!.length
                ? ThemeModeModel.lightPrimary
                : const Color.fromARGB(255, 255, 233, 199)),
        onPressed: () {
          intermediateLength / 2 == widget.intermediateSkills?.length
              ? removeItems(intermediateWidgets)
              : addItems(intermediateWidgets, widget.intermediateSkills!);

          print(
              '${widget.intermediateSkills!.length} : ${intermediateLength / 2}');
        },
        label: intermediateLength / 2 == widget.intermediateSkills?.length
            ? const Text('Show less')
            : const Text('Show more'),
      ));
    });
  }

  void removeItems(List<Widget> widgets) {
    setState(() {
      while (widgets.length / 2 != minTags) {
        widgets.removeLast();
      }
      intermediateLength = intermediateWidgets.length;

      intermediateWidgets.add(ActionChip(
        elevation: 2,
        backgroundColor: tagsToShow < widget.intermediateSkills!.length
            ? ThemeModeModel.lightSecondary
            : ThemeModeModel.lightBackground,
        side: BorderSide(
            color: tagsToShow < widget.intermediateSkills!.length
                ? ThemeModeModel.lightPrimary
                : const Color.fromARGB(255, 255, 233, 199)),
        onPressed: () {
          intermediateLength / 2 == widget.intermediateSkills?.length
              ? removeItems(intermediateWidgets)
              : addItems(intermediateWidgets, widget.intermediateSkills!);

          print(
              '${widget.intermediateSkills!.length} : ${intermediateLength / 2}');
        },
        label: intermediateLength / 2 == widget.intermediateSkills?.length
            ? const Text('Show less')
            : const Text('Show more'),
      ));
    });
  }

  void toggleTagCount(int count) {
    setState(() {
      tagsToShow = tagsToShow == count ? minTags : count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      profileHeader: 'Skills',
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Fundamental'),
        ),
        Wrap(
          spacing: 8,
          children: [
            if (widget.fundamentalSkills!.isNotEmpty)
              for (TagsSolved skill in widget.fundamentalSkills!)
                Chip(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 219, 237, 253),
                  ),
                  label: Text("${skill.tagName!} x${skill.problemsSolved}"),
                  backgroundColor: const Color.fromARGB(255, 247, 251, 255),
                ),
          ],
        ),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Intermediate'),
        ),
        Wrap(
          children: AnimateList(
            interval: 10.ms,
            effects: [FadeEffect(duration: 80.ms)],
            children: intermediateWidgets,
          ),
        ),
        // Wrap(
        //   spacing: 8,
        //   children: [
        //     if (widget.intermediateSkills!.isNotEmpty) ...{
        //       for (int i = 0;
        //           i < min(widget.intermediateSkills!.length, tagsToShow);
        //           ++i)
        //         Chip(
        //           side: const BorderSide(
        //             color: Color.fromARGB(255, 201, 231, 255),
        //           ),
        //           label: Text(
        //               "${widget.intermediateSkills![i].tagName!} x${widget.intermediateSkills![i].problemsSolved}"),
        //           backgroundColor: const Color.fromARGB(255, 238, 248, 255),
        //         ),
        //       ActionChip(
        //         elevation: 2,
        //         backgroundColor: tagsToShow < widget.intermediateSkills!.length
        //             ? ThemeModeModel.lightSecondary
        //             : ThemeModeModel.lightBackground,
        //         side: BorderSide(
        //             color: tagsToShow < widget.intermediateSkills!.length
        //                 ? ThemeModeModel.lightPrimary
        //                 : Color.fromARGB(255, 255, 233, 199)),
        //         onPressed: () =>
        //             toggleTagCount(widget.intermediateSkills!.length),
        //         label: tagsToShow < widget.intermediateSkills!.length
        //             ? const Text('Show more')
        //             : const Text('Show less'),
        //       ),
        //     }
        //   ],
        // ),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Advanced'),
        ),
        Wrap(
          spacing: 8,
          children: [
            if (widget.advancedSkills!.isNotEmpty)
              for (TagsSolved skill in widget.advancedSkills!)
                Chip(
                  side: BorderSide(
                    color: Colors.blue.shade200,
                  ),
                  label: Text("${skill.tagName!} x${skill.problemsSolved}"),
                  backgroundColor: const Color.fromARGB(255, 223, 241, 255),
                ),
          ],
        ),
        //   TagCard(
        //     fundamentalSkills: fundamentalSkills,
        //     tagHeader: 'Fundamental',
        //     backgroundColor: const Color.fromARGB(255, 247, 251, 255),
        //     borderColor: const Color.fromARGB(255, 219, 237, 253),
        //   ),
        // if (intermediateSkills!.isNotEmpty) ...{
        //   const SizedBox(height: 10),
        //   TagCard(
        //     fundamentalSkills: intermediateSkills,
        //     tagHeader: 'Intermediate',
        //     backgroundColor: const Color.fromARGB(255, 238, 248, 255),
        //     borderColor: const Color.fromARGB(255, 201, 231, 255),
        //   ),
        // },
        // if (advancedSkills!.isNotEmpty) ...{
        //   const SizedBox(height: 10),
        //   TagCard(
        //     fundamentalSkills: advancedSkills,
        //     tagHeader: 'Advanced',
        //     backgroundColor: const Color.fromARGB(255, 223, 241, 255),
        //     borderColor: Colors.blue.shade200,
        //   ),
        // }
      ],
    );
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
