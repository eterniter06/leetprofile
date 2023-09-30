import 'dart:math';

import 'package:flutter/material.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import 'test.dart';

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
  List<Widget> intermediateWidgets = [];
  List<Widget> fundamentalWidgets = [];
  List<Widget> advancedWidgets = [];

  @override
  void initState() {
    super.initState();

    if (widget.fundamentalSkills!.isNotEmpty) {
      for (TagsSolved skill in widget.fundamentalSkills!) {
        Chip fundamentalSkillChip = Chip(
          side: const BorderSide(
            color: Color.fromARGB(255, 219, 237, 253),
          ),
          label: Text("${skill.tagName!} x${skill.problemsSolved}"),
          backgroundColor: const Color.fromARGB(255, 247, 251, 255),
        );
        fundamentalWidgets.add(fundamentalSkillChip);
      }
    }

    if (widget.intermediateSkills!.isNotEmpty) {
      for (TagsSolved skill in widget.intermediateSkills!) {
        Chip intermediateSkillChip = Chip(
          side: const BorderSide(
            color: Color.fromARGB(255, 201, 231, 255),
          ),
          label: Text("${skill.tagName!} x${skill.problemsSolved}"),
          backgroundColor: const Color.fromARGB(255, 238, 248, 255),
        );
        intermediateWidgets.add(intermediateSkillChip);
      }
    }

    if (widget.advancedSkills!.isNotEmpty) {
      for (TagsSolved skill in widget.advancedSkills!) {
        Chip advancedSkillChip = Chip(
          side: BorderSide(
            color: Colors.blue.shade200,
          ),
          label: Text("${skill.tagName!} x${skill.problemsSolved}"),
          backgroundColor: const Color.fromARGB(255, 223, 241, 255),
        );
        advancedWidgets.add(advancedSkillChip);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      profileHeader: 'Skills',
      children: [
        if (fundamentalWidgets.isNotEmpty) ...{
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Fundamental'),
          ),
          ExtensibleAnimatedWrap(
            defaultItemCount: minTags,
            spacing: 8,
            children: fundamentalWidgets,
          ),
        },
        if (intermediateWidgets.isNotEmpty) ...{
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Intermediate'),
          ),
          ExtensibleAnimatedWrap(
            defaultItemCount: minTags,
            spacing: 8,
            children: intermediateWidgets,
          ),
        },
        if (advancedWidgets.isNotEmpty) ...{
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Advanced'),
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

class ExtensibleAnimatedWrap extends StatefulWidget {
  const ExtensibleAnimatedWrap({
    required this.children,
    this.spacing,
    this.defaultItemCount,
    super.key,
  });
  final double? spacing;
  final List<Widget> children;
  final int? defaultItemCount;
  @override
  State<ExtensibleAnimatedWrap> createState() => _ExtensibleAnimatedWrapState();
}

class _ExtensibleAnimatedWrapState extends State<ExtensibleAnimatedWrap> {
  List<Widget> list = [];
  List<Function> callback = [];
  bool expanded = false;
  Duration animationDuration = const Duration(milliseconds: 0);

  late int defaultItemCount = widget.defaultItemCount != null
      ? min(widget.defaultItemCount!, widget.children.length)
      : widget.children.length;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < defaultItemCount; ++i) {
      list.add(widget.children[i]);
    }

    if (widget.defaultItemCount != null) {
      int animatedWidgetCount = widget.children.length - defaultItemCount;

      if (animatedWidgetCount < 8) {
        animationDuration = const Duration(milliseconds: 80);
      }
      if (animatedWidgetCount < 20) {
        animationDuration = const Duration(milliseconds: 60);
      }
      if (animatedWidgetCount >= 20) {
        animationDuration = const Duration(milliseconds: 30);
      }
    }
  }

  void toggle() {
    if (widget.defaultItemCount != null) {
      if (!expanded) {
        for (int i = defaultItemCount; i < widget.children.length; ++i) {
          setState(() {
            list.add(
              AnimatedTag(
                  duration: animationDuration,
                  onEnd: () => setState(() {
                        list.removeAt(i);
                      }),
                  toggle: (toggleVisibility) {
                    callback.add(toggleVisibility);
                  },
                  child: widget.children[i]),
            );
          });
        }
      } else {
        setState(() {
          for (int i = callback.length - 1; i >= 0; --i) {
            callback[i].call();
          }
          callback.clear();
        });
      }
      setState(() {
        expanded = !expanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing ?? 0.0,
      children: [
        ...list,
        if (widget.children.length > defaultItemCount)
          ElevatedButton(
            child: AnimatedCrossFade(
              duration: animationDuration,
              crossFadeState: CrossFadeState.showFirst,
              firstChild: widget.children.length == list.length
                  ? const Text('Show less')
                  : const Text('Show more'),
              secondChild: widget.children.length != list.length
                  ? const Text('Show less')
                  : const Text('Show more'),
            ),
            onPressed: () => toggle(),
          ),
      ],
    );
  }
}
