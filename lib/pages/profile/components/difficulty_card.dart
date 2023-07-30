import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProblemCard extends StatelessWidget {
  const ProblemCard({
    super.key,
    required this.problemCategory,
    required this.solved,
    required this.total,
  });

  final String problemCategory;
  final int solved;
  final int total;

  double calculatePercent() {
    if (total == 0) return 0;
    return solved.toDouble() / total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border(
            bottom: BorderSide(),
            top: BorderSide(),
            left: BorderSide(),
            right: BorderSide(),
          )),
      child: Column(
        children: [
          const SizedBox(height: 8),
          CircularPercentIndicator(
            radius: 60,
            animation: true,
            animationDuration: 700,
            curve: Curves.decelerate,
            circularStrokeCap: CircularStrokeCap.round,
            arcType: ArcType.HALF,
            footer: Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              child: Text(
                problemCategory,
              ),
            ),
            // rotateLinearGradient: true,
            center: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$solved',
                ),
                const Divider(
                  endIndent: 32,
                  indent: 32,
                ),
                Text(
                  '$total',
                ),
              ],
            ),
            percent: calculatePercent(),
          ),
        ],
      ),
    );
  }
}
