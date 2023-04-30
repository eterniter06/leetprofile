import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_elements/database.dart';
import 'package:ui_elements/dataclass/data_parser.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class UserView extends StatefulWidget {
  final UserData userData;
  const UserView({super.key, required this.userData});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
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
        title: Text(widget.userData.nickname),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () =>
                Share.share('https://leetcode.com/${widget.userData.username}'),
          ),
          IconButton(
            icon: const Icon(Icons.replay_rounded),
            onPressed: () async {
              var dataMap = await DataParser(username: widget.userData.username)
                  .getAllAsJson();

              setState(() {
                widget.userData
                    .update(updatedUser: UserData.fromMap(dataMap: dataMap!));
              });

              var isar = await Database.isar();
              isar!.writeTxn(() async {
                await isar.userDatas.put(widget.userData);
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Image.network(
                      widget.userData.avatar,
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
                          widget.userData.username,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: valueScaler(context, 24.0),
                            fontFamily: 'Overpass',
                          ),
                        ),
                        Text(
                            'Contest Rating: ${widget.userData.userContestRanking?.rating.round()}'),
                        Text(
                            'Contests Attended: ${widget.userData.userContestRanking?.attendedContestsCount}'),
                        Text(
                            'Global Ranking: ${widget.userData.userContestRanking?.globalRanking}'),
                        Text(
                            'Top percentage: ${widget.userData.userContestRanking?.topPercentage}'),
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
                      Padding(
                        padding: EdgeInsets.all(
                          valueScaler(context, 12.0),
                        ),
                        child: Text(
                          'Difficulty',
                          style: TextStyle(
                            fontSize: valueScaler(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      DifficultySection(
                        problemData: widget.userData.problemData,
                        valueScaler: valueScaler,
                      ),
                      SizedBox(
                        height: valueScaler(context, 16),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: valueScaler(context, 6.0),
                          horizontal: valueScaler(context, 12.0),
                        ),
                        child: Text(
                          'Language',
                          style: TextStyle(
                            fontSize: valueScaler(context, 16),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      LanguageSection(
                          valueScaler: valueScaler,
                          languageProblemList:
                              widget.userData.languageProblemCount ?? []),
                      const Divider(),
                      Container(
                        padding: EdgeInsets.all(valueScaler(context, 4)),
                        margin: EdgeInsets.only(top: valueScaler(context, 5)),
                        child: Text(
                          'Total problems solved: ${getSolvedCount(widget.userData.problemData)}',
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
              RecentSubmissionSection(
                  valueScaler: valueScaler,
                  submissionList: widget.userData.recentAcSubmissionList ?? []),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageSection extends StatelessWidget {
  const LanguageSection(
      {super.key,
      required this.languageProblemList,
      required this.valueScaler});
  final List<LanguageSubmission> languageProblemList;
  final Function valueScaler;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: valueScaler(context, 140),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: languageProblemList.length,
        itemBuilder: (BuildContext context, int index) => LanguageCard(
          languageDetails: languageProblemList[index],
          valueScaler: valueScaler,
        ),
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  const LanguageCard(
      {super.key, required this.languageDetails, required this.valueScaler});
  final LanguageSubmission languageDetails;
  final Function valueScaler;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AspectRatio(
        aspectRatio: 1.3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    languageDetails.languageName!,
                    style: TextStyle(
                      color: Colors.teal[200],
                      fontSize: valueScaler(context, 26),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: valueScaler(context, 48),
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(
                      valueScaler(context, 16),
                    ),
                  ),
                  child: Center(
                    heightFactor: 1,
                    child: Padding(
                      padding: EdgeInsets.all(valueScaler(context, 4)),
                      child: Text(
                        languageDetails.problemsSolved.toString(),
                        style: TextStyle(
                          fontSize: valueScaler(context, 14),
                          color: Colors.teal[900],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      ),
    );
  }
}

class RecentSubmissionSection extends StatefulWidget {
  const RecentSubmissionSection(
      {super.key, required this.submissionList, required this.valueScaler});
  final List<RecentSubmission> submissionList;
  final Function valueScaler;
  @override
  State<RecentSubmissionSection> createState() =>
      _RecentSubmissionSectionState();
}

class _RecentSubmissionSectionState extends State<RecentSubmissionSection> {
  @override
  Widget build(BuildContext context) {
    return widget.submissionList.isEmpty
        ? Card(
            child: Padding(
              padding: EdgeInsets.all(widget.valueScaler(context, 8.0)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(widget.valueScaler(context, 8.0)),
                  child: Text(
                    'No Recent Submissions',
                    style: TextStyle(
                      color: Color.lerp(Colors.black, Colors.white, 0.3),
                      fontSize: widget.valueScaler(context, 24),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Card(
            child: Padding(
              padding: EdgeInsets.all(widget.valueScaler(context, 8.0)),
              child: ExpansionTile(
                initiallyExpanded: false,
                collapsedTextColor: Colors.amber,
                textColor: Colors.amberAccent,
                title: Text(
                  'Recent Submissions',
                  style: TextStyle(
                    fontSize: widget.valueScaler(context, 24),
                  ),
                ),
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.submissionList.length,
                    itemBuilder: (context, index) => RecentSubmissionCard(
                        submission: widget.submissionList[index]),
                  ),
                ],
              ),
            ),
          );
  }
}

class RecentSubmissionCard extends StatelessWidget {
  const RecentSubmissionCard({super.key, required this.submission});
  final RecentSubmission submission;

  String getOrdinal(DateTime submissionTime) {
    final day = int.parse(DateFormat('dd').format(submissionTime));
    if (day >= 10 && day <= 20) return "th";

    return day % 10 == 1
        ? "st"
        : day % 10 == 2
            ? "nd"
            : day % 10 == 3
                ? "rd"
                : "th";
  }

  String getTimeFromEpochsInSeconds() {
    final submissionTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(submission.timestamp!) * Duration.millisecondsPerSecond)
        .toLocal();

    final ordinal = getOrdinal(submissionTime);
    final dateTimeFormatter = DateFormat("dd'$ordinal' MMMM yyyy HH:mm:ss");

    return dateTimeFormatter.format(submissionTime);
  }

  String getTimeOfDay() {
    final submissionTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(submission.timestamp!) * Duration.millisecondsPerSecond)
        .toLocal();

    return DateFormat("HH:mm:ss").format(submissionTime);
  }

  String getDay() {
    final submissionTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(submission.timestamp!) * Duration.millisecondsPerSecond)
        .toLocal();

    final ordinal = getOrdinal(submissionTime);
    final dateTimeFormatter = DateFormat("dd'$ordinal' MMMM yyyy");

    return dateTimeFormatter.format(submissionTime);
  }

  Future<void> _launchQuestionUrl() async {
    Uri questionLink =
        Uri.parse('https://leetcode.com/problems/${submission.titleSlug}');

    if (await canLaunchUrl(questionLink)) {
      await launchUrl(questionLink, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not open Question url');
    }
  }

  Future<void> _launchSubmissionUrl() async {
    Uri questionLink =
        Uri.parse('https://leetcode.com/submissions/detail/${submission.id}');

    if (await canLaunchUrl(questionLink)) {
      await launchUrl(questionLink, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not open Question url');
    }
  }

  // void _launchQuestionMenu() {
  //   DropdownButton(
  //     items: [
  //       Text('Copy Question URL'),

  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _launchQuestionUrl(),
        // onLongPress: () => _launchQuestionMenu(),
        child: ListTile(
          leading: IconButton(
            splashRadius: 30,
            icon: const Icon(Icons.question_answer),
            onPressed: () async {
              await _launchSubmissionUrl();
            },
          ),

          /* Refer to: 
          *  https://github.com/flutter/flutter/issues/53797
          *  for why the question title isn't copyable
          */
          title: Text(
            submission.title!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(getTimeOfDay()),
          subtitle: Text(getDay()),
        ),
      ),
    );
  }
}
