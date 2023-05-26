import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DifficultyCard extends StatelessWidget {
  const DifficultyCard({
    super.key,
    required this.problemCategory,
    required this.solved,
    required this.total,
  });

  final String problemCategory;
  final int solved;
  final int total;

  Color getColor() {
    switch (problemCategory.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return const Color.fromRGBO(253, 216, 53, 1);
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getBackgroundColor() {
    switch (problemCategory.toLowerCase()) {
      case 'easy':
        return const Color.fromRGBO(200, 230, 201, 1);
      case 'medium':
        return const Color.fromRGBO(255, 245, 157, 1);
      case 'hard':
        return const Color.fromRGBO(255, 205, 210, 1);
      default:
        return Colors.grey;
    }
  }

  double calculatePercent() {
    if (total == 0) return 0;
    return solved.toDouble() / total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
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
              child: Card(
                elevation: 0,
                child: Text(
                  problemCategory,
                ),
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
