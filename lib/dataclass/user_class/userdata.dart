import 'problemdata.dart';

class UserData {
  final String username;
  String nickname;
  String? realname;
  String? avatar;

  ProblemData? problemData;

  List? recentAcSubmissionList;

  List? badges;

  List? languageProblemCount;

  List? fundamentalTagsSolved;
  List? intermediateTagsSolved;
  List? advancedTagsSolved;

  String? linkedinUrl;
  String? githubUrl;

  Map? dailyChallenge;

  Map? allQuestionsCount;

  Map? userContestRanking;
  List? userContestRankingHistory;

  void refresh() {}

  UserData({
    required this.username,
    required this.nickname,
    this.avatar,
    this.realname,
  });

  UserData.fromMap({required Map dataMap})
      : username = dataMap['username'],
        nickname = dataMap['nickname'],
        realname = dataMap['realname'],
        recentAcSubmissionList = dataMap['recentAcSubmissionList'],
        avatar = dataMap['avatar'],
        badges = dataMap['badges'],
        languageProblemCount = dataMap['languageProblemCount'],
        fundamentalTagsSolved = dataMap['fundamentalTagsSolved'],
        intermediateTagsSolved = dataMap['intermediateTagsSolved'],
        advancedTagsSolved = dataMap['advancedTagsSolved'],
        linkedinUrl = dataMap['linkedinUrl'],
        githubUrl = dataMap['githubUrl'],
        dailyChallenge = dataMap['dailyChallenge'],
        allQuestionsCount = dataMap['allQuestionDifficultyCount'],
        userContestRanking = dataMap['userContestRanking'],
        userContestRankingHistory = dataMap['userContestRankingHistory'],
        problemData = ProblemData.fromMap(
          solvedCount: dataMap['submissionStats'],
          allCount: dataMap['allQuestionDifficultyCount'],
        );
}
