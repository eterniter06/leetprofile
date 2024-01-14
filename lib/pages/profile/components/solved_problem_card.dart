import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/providers/theme.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/common_components/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

import 'difficulty_card.dart';

class SolvedProblemsCard extends StatelessWidget implements ClassName {
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
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);

    return ProfileCard(
      profileHeader: 'Solved Problems',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              Expanded(
                child: ProblemCard(
                  problemCategory: Text(
                    'Easy',
                    style: TextStyle(
                      color: Colors.green.shade800,
                    ),
                  ),
                  borderColor: Colors.green.shade300,
                  containerColor: Colors.lightGreen.shade50,
                  progressColor: Colors.green.shade800,
                  backgroundArcColor: Colors.green.shade200,
                  solved: problemData?.easySolved ?? 0,
                  total: problemData?.easyTotal ?? 0,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ProblemCard(
                  problemCategory: const Text(
                    'Medium',
                    style: TextStyle(
                      color: Color.fromRGBO(98, 92, 18, 1),
                    ),
                  ),
                  containerColor: Colors.yellow.shade50,
                  progressColor: const Color.fromRGBO(98, 92, 18, 1),
                  borderColor: Colors.yellow.shade700,
                  backgroundArcColor: Colors.yellow.shade600,
                  solved: problemData?.mediumSolved ?? 0,
                  total: problemData?.mediumTotal ?? 0,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ProblemCard(
                  problemCategory: Text(
                    'Hard',
                    style: TextStyle(
                      color: Colors.red.shade800,
                    ),
                  ),
                  borderColor: Colors.red.shade300,
                  containerColor: Colors.red.shade50,
                  progressColor: Colors.red.shade800,
                  backgroundArcColor: Colors.red.shade200,
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
            child: Consumer<ThemeModeModel>(
              builder: (context, themeModeModel, child) => Text.rich(
                TextSpan(
                    text: 'Total problems solved: ',
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: getSolvedCount(problemData).toString(),
                        style: TextStyle(
                          inherit: true,
                          color: themeModeModel.equivalentThemeMode(
                                      platformBrightness) ==
                                  ThemeMode.light
                              ? ThemeModeModel.lightSecondaryInverse
                              : ThemeModeModel.lightPrimary,
                        ),
                      ),
                    ]),
              ),
            )
            // Text(
            //   'Total problems solved: ${getSolvedCount(problemData)}',
            // ),
            ),
      ],
    );
  }

  @override
  String className() {
    return 'SolvedProblemsCard';
  }
}
