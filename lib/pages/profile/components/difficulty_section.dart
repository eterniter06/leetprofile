import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/components/problem_card.dart';

class DifficultySection extends StatelessWidget {
  const DifficultySection({
    super.key,
    this.problemData,
  });

  final ProblemData? problemData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DifficultyCard(
            problemCategory: 'Easy',
            solved: problemData?.easySolved ?? 0,
            total: problemData?.easyTotal ?? 0,
          ),
        ),
        Expanded(
          child: DifficultyCard(
            problemCategory: 'Medium',
            solved: problemData?.mediumSolved ?? 0,
            total: problemData?.mediumTotal ?? 0,
          ),
        ),
        Expanded(
          child: DifficultyCard(
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
