import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ui_elements/dataclass/data_parser.dart';
import 'package:ui_elements/dataclass/user_class/problemdata.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';

class UserView extends StatefulWidget {
  final UserData userData;
  const UserView({super.key, required this.userData});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  UserData? currentUser;

  num getSolvedCount(ProblemData? problemData) {
    return problemData == null
        ? 0
        : problemData.easySolved +
            problemData.mediumSolved +
            problemData.hardSolved;
  }

  double valueScaler(BuildContext context, num value) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double ratio = width / 590.0;

    return ratio * value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                var dataMap = await DataParser(
                        username: (currentUser ?? widget.userData).username)
                    .getAllAsJson();

                setState(() {
                  currentUser = UserData.fromMap(dataMap: dataMap);
                });
              },
              icon: const Icon(Icons.replay_rounded))
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, currentUser ?? widget.userData);
          return false;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Image.network(
                        (currentUser ?? widget.userData).avatar ?? '',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (currentUser ?? widget.userData).nickname,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: valueScaler(context, 24.0),
                              fontFamily: 'Overpass',
                            ),
                          ),
                          Text(
                              'Contest Rating: ${(currentUser ?? widget.userData).userContestRanking?['rating'].round()}'),
                          Text(
                              'Contests Attended: ${(currentUser ?? widget.userData).userContestRanking?['attendedContestsCount']}'),
                          Text(
                              'Global Ranking: ${(currentUser ?? widget.userData).userContestRanking?['globalRanking']}'),
                          Text(
                              'Top percentage: ${(currentUser ?? widget.userData).userContestRanking?['topPercentage']}'),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(valueScaler(context, 8.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(valueScaler(context, 8.0)),
                          child: Text(
                            'Solved Problems',
                            style: TextStyle(
                              fontSize: valueScaler(context, 24),
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        ProblemSection(
                          problemData:
                              (currentUser ?? widget.userData).problemData,
                          valueScaler: valueScaler,
                        ),
                        Container(
                          padding: EdgeInsets.all(valueScaler(context, 4)),
                          margin:
                              EdgeInsets.only(top: valueScaler(context, 10)),
                          child: Text(
                            'Total problems solved: ${getSolvedCount((currentUser ?? widget.userData).problemData)}',
                            style: TextStyle(
                              fontSize: valueScaler(context, 20),
                              color: const Color.fromRGBO(97, 97, 97, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProblemSection extends StatelessWidget {
  const ProblemSection({
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
          child: ProblemCard(
            valueScaler: valueScaler,
            problemCategory: 'Easy',
            solved: problemData?.easySolved ?? 0,
            total: problemData?.easyTotal ?? 0,
          ),
        ),
        Expanded(
          child: ProblemCard(
            valueScaler: valueScaler,
            problemCategory: 'Medium',
            solved: problemData?.mediumSolved ?? 0,
            total: problemData?.mediumTotal ?? 0,
          ),
        ),
        Expanded(
          child: ProblemCard(
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

class ProblemCard extends StatelessWidget {
  const ProblemCard({
    super.key,
    required this.problemCategory,
    required this.solved,
    required this.total,
    required this.valueScaler,
  });

  final Function valueScaler;

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
        shadowColor: Colors.amber,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Column(
            children: [
              SizedBox(height: valueScaler(context, 8)),
              CircularPercentIndicator(
                radius: valueScaler(context, 60),
                animation: true,
                animationDuration: 700,
                curve: Curves.decelerate,
                progressColor: getColor(),
                circularStrokeCap: CircularStrokeCap.round,
                arcType: ArcType.HALF,
                arcBackgroundColor: getBackgroundColor(),
                footer: Card(
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: valueScaler(context, 8),
                      vertical: valueScaler(context, 2),
                    ),
                    child: Text(
                      problemCategory,
                      style: TextStyle(fontSize: valueScaler(context, 20)),
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
                      style: TextStyle(
                        fontSize: valueScaler(context, 32),
                      ),
                    ),
                    Divider(
                      endIndent: valueScaler(context, 32),
                      indent: valueScaler(context, 32),
                    ),
                    Text(
                      '$total',
                      style: TextStyle(fontSize: valueScaler(context, 22)),
                    ),
                  ],
                ),
                percent: calculatePercent(),
              ),
            ],
          ),
        ));
  }
}

class RecentSubmissionCard extends StatefulWidget {
  const RecentSubmissionCard({super.key});

  @override
  State<RecentSubmissionCard> createState() => _RecentSubmissionCardState();
}

class _RecentSubmissionCardState extends State<RecentSubmissionCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
