import 'package:flutter/material.dart';
import 'package:ui_elements/components/problem_card.dart';

import 'dataclass/user_class/userdata.dart';

class DifficultySection extends StatelessWidget {
  const DifficultySection({
    super.key,
    this.problemData,
    required this.valueScaler,
  });

  final ProblemData? problemData;
  final Function valueScaler;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DifficultyCard(
            valueScaler: valueScaler,
            problemCategory: 'Easy',
            solved: problemData?.easySolved ?? 0,
            total: problemData?.easyTotal ?? 0,
          ),
        ),
        Expanded(
          child: DifficultyCard(
            valueScaler: valueScaler,
            problemCategory: 'Medium',
            solved: problemData?.mediumSolved ?? 0,
            total: problemData?.mediumTotal ?? 0,
          ),
        ),
        Expanded(
          child: DifficultyCard(
            valueScaler: valueScaler,
            problemCategory: 'Hard',
            solved: problemData?.hardSolved ?? 0,
            total: problemData?.hardTotal ?? 0,
          ),
        ),
        // ProblemCard(),
      ],
    );
  }
}
