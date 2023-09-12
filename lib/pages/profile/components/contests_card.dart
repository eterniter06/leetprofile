import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';

class ContestCard extends StatefulWidget {
  const ContestCard({
    super.key,
    required this.contests,
    required this.overallContestData,
  });

  final List<ContestSummary> contests;
  final ContestRanking overallContestData;

  @override
  State<ContestCard> createState() => _ContestCardState();
}

class _ContestCardState extends State<ContestCard> {
  int? indexTouched;

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      profileHeader: 'Contests',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AspectRatio(
            aspectRatio:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 4,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? touchResponse) {
                    setState(() {
                      if (event.isInterestedForInteractions) {
                        indexTouched =
                            touchResponse?.lineBarSpots?[0].x.toInt() ??
                                indexTouched;
                      } else {
                        indexTouched = null;
                      }
                    });
                  },
                  getTouchedSpotIndicator:
                      (LineChartBarData barData, List<int> indicators) {
                    return indicators.map(
                      (int index) {
                        const line = FlLine(
                            color: Colors.grey,
                            strokeWidth: 1,
                            dashArray: [2, 4]);
                        return const TouchedSpotIndicatorData(
                          line,
                          FlDotData(show: false),
                        );
                      },
                    ).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.blue,
                    tooltipRoundedRadius: 20.0,
                    fitInsideVertically: true,
                    showOnTopOfTheChartBoxArea: true,
                    fitInsideHorizontally: true,
                    tooltipMargin: 0,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map(
                        (LineBarSpot touchedSpot) {
                          const textStyle = TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          );

                          ContestSummary contest =
                              widget.contests[touchedSpot.spotIndex];

                          return LineTooltipItem(
                            "${contest.title!}\n${contest.rating}",
                            textStyle,
                          );
                        },
                      ).toList();
                    },
                  ),
                ),
                borderData: FlBorderData(
                    border:
                        const Border(bottom: BorderSide(), left: BorderSide())),
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    dotData: FlDotData(
                      getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                          radius: 2.5,
                          // invert colors according to dark/white mode
                          color: Colors.white,
                          strokeColor: Colors.black),
                    ),
                    spots: List.generate(
                      widget.contests.length,
                      (index) => FlSpot(
                        index.toDouble(),
                        widget.contests[index].rating!.toDouble(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        indexTouched == null
            ? ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(widget.overallContestData.attendedContestsCount
                            .toString()),
                        const Text('Contests'),
                        const Text('attended'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(widget.overallContestData.rating
                            .toStringAsFixed(2)),
                        const Text('Contest'),
                        const Text('rating'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                            widget.overallContestData.globalRanking.toString()),
                        const Text('Global'),
                        const Text('ranking'),
                      ],
                    ),
                    Column(children: [
                      Text(widget.overallContestData.topPercentage
                          .toStringAsFixed(2)),
                      const Text('Top %'),
                    ]),
                  ],
                ),
              )
            : ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                            "${widget.contests[indexTouched!].problemsSolved}/${widget.contests[indexTouched!].totalProblems}"),
                        const Text('Problems'),
                        const Text('solved'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(widget.contests[indexTouched!].rating!
                            .toStringAsFixed(2)),
                        const Text('Rating'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(widget.contests[indexTouched!].ranking.toString()),
                        const Text('Ranking'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  widget.contests[indexTouched!].startTime! *
                                      1000)
                              .toIso8601String()
                              .substring(0, 10),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ],
    );
  }
}
