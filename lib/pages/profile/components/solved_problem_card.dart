import 'package:flutter/material.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';

import 'difficulty_card.dart';

class SolvedProblemsCard extends StatelessWidget {
  const SolvedProblemsCard({
    super.key,
    required this.problemData,
  });

  final ProblemData? problemData;

  num getSolvedCount(ProblemData? problemData) {
    return problemData == null
        ? 0
        : problemData.easySolved +
            problemData.mediumSolved +
            problemData.hardSolved;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Solved Problems',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: ProblemCard(
                      problemCategory: 'Easy',
                      solved: problemData?.easySolved ?? 0,
                      total: problemData?.easyTotal ?? 0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ProblemCard(
                      problemCategory: 'Medium',
                      solved: problemData?.mediumSolved ?? 0,
                      total: problemData?.mediumTotal ?? 0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ProblemCard(
                      problemCategory: 'Hard',
                      solved: problemData?.hardSolved ?? 0,
                      total: problemData?.hardTotal ?? 0,
                    ),
                  ),
                  // ProblemCard(),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Total problems solved: ${getSolvedCount(problemData)}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
