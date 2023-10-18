import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ui_elements/providers/theme.dart';

class ProblemCard extends StatelessWidget {
  const ProblemCard({
    super.key,
    required this.problemCategory,
    required this.solved,
    required this.total,
    this.radius = 56,
    this.progressColor,
    this.backgroundArcColor,
    required this.containerColor,
    this.borderColor = Colors.black,
  });

  final Widget problemCategory;
  final int solved;
  final int total;
  final double radius;
  final Color? progressColor;
  final Color? backgroundArcColor;
  final Color containerColor;
  final Color borderColor;
  double calculatePercent() {
    if (total == 0) return 0;
    return solved.toDouble() / total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: containerColor,
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CircularPercentIndicator(
                  radius: constraints.maxWidth * 1 / 3,
                  animation: true,
                  animationDuration: 700,
                  curve: Curves.decelerate,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: progressColor,
                  arcBackgroundColor: backgroundArcColor,
                  arcType: ArcType.HALF,
                  footer: Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: problemCategory,
                  ),
                  // rotateLinearGradient: true,
                  center: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$solved',
                        style: TextStyle(
                          color: ThemeModeModel.getInverseBW(containerColor),
                        ),
                      ),
                      Divider(
                        endIndent: constraints.maxWidth * 1 / 3 * 60 / 100,
                        indent: constraints.maxWidth * 1 / 3 * 60 / 100,
                      ),
                      Text(
                        '$total',
                        style: TextStyle(
                          color: ThemeModeModel.getInverseBW(containerColor),
                        ),
                      ),
                    ],
                  ),
                  percent: calculatePercent(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
