import 'package:isar/isar.dart';
part 'userdata.g.dart';

@collection
class UserData {
  final String username;

  Id get isarId => fastHash(username);
  int? listOrder;

  late String? nickname;
  late String realname;
  late String avatar;
  late String ranking;
  late String reputation;
  late String solutionCount;
  late String postViewCount;

  List<SubmissionCalendarDate>? submissionActivity;
  int totalActiveDays;

  String? linkedinUrl;
  String? githubUrl;

  ProblemData? problemData;

  List<RecentSubmission>? recentAcSubmissionList;

  List<UserBadge>? badges;

  List<LanguageSubmission>? languageProblemCount;

  List<TagsSolved>? fundamentalTags;
  List<TagsSolved>? intermediateTags;
  List<TagsSolved>? advancedTags;

  List<AllQuestions>? allQuestionsCount;

  ContestRanking? userContestRanking;
  List<ContestSummary>? userContestRankingHistory;

  DateTime lastFetchTime;

  void updateNickname(String newNickname) {
    nickname = newNickname;
  }

  void update({required UserData updatedUser}) {
    if (updatedUser.username != username) {
      throw '''Usernames do not match:
      Old: "$username"
      New: "${updatedUser.username}"''';
    }

    lastFetchTime = updatedUser.lastFetchTime;

    // Nickname is local data, not fetched from server
    // Nickname is only changed via the user

    realname = updatedUser.realname;
    avatar = updatedUser.avatar;
    ranking = updatedUser.ranking;
    reputation = updatedUser.reputation;
    solutionCount = updatedUser.solutionCount;
    postViewCount = updatedUser.postViewCount;

    listOrder = updatedUser.listOrder;

    linkedinUrl = updatedUser.linkedinUrl;
    githubUrl = updatedUser.githubUrl;

    problemData = updatedUser.problemData;
    recentAcSubmissionList = updatedUser.recentAcSubmissionList;
    badges = updatedUser.badges;

    languageProblemCount = updatedUser.languageProblemCount;

    fundamentalTags = updatedUser.fundamentalTags;
    intermediateTags = updatedUser.intermediateTags;
    advancedTags = updatedUser.advancedTags;

    allQuestionsCount = updatedUser.allQuestionsCount;
    userContestRanking = updatedUser.userContestRanking;
    userContestRankingHistory = updatedUser.userContestRankingHistory;

    submissionActivity = updatedUser.submissionActivity;
    totalActiveDays = updatedUser.totalActiveDays;
  }

  UserData({
    required this.username,
    this.nickname,
    required this.avatar,
    required this.realname,
    required this.lastFetchTime,
    this.totalActiveDays = 0,
  });

  UserData.fromMap({required Map dataMap})
      : username = dataMap['username'],
        nickname = dataMap['nickname'],
        lastFetchTime = dataMap['lastFetchTime'],
        realname = dataMap['realname'],
        avatar = dataMap['avatar'],
        ranking = dataMap['ranking'],
        reputation = dataMap['reputation'],
        solutionCount = dataMap['solutionCount'],
        postViewCount = dataMap['postViewCount'],
        recentAcSubmissionList = dataMap['recentAcSubmissionList'],
        badges = dataMap['badges'],
        languageProblemCount = dataMap['languageProblemCount'],
        fundamentalTags = dataMap['fundamentalTagsSolved'],
        intermediateTags = dataMap['intermediateTagsSolved'],
        advancedTags = dataMap['advancedTagsSolved'],
        linkedinUrl = dataMap['linkedinUrl'],
        githubUrl = dataMap['githubUrl'],
        allQuestionsCount = dataMap['allQuestionDifficultyCount'],
        userContestRanking = dataMap['userContestRanking'],
        userContestRankingHistory = dataMap['userContestRankingHistory'],
        problemData = ProblemData.fromMap(
          solvedCount: dataMap['submissionStats'],
          allCount: dataMap['allQuestionDifficultyCount'],
        ),
        totalActiveDays = dataMap['totalActiveDays'],
        submissionActivity = dataMap['submissionCalendar'];
}

// Taken from the isar FAQ
int fastHash(String username) {
  var hash = 0xcbf29ce484222325;
  int i = 0;

  while (i < username.length) {
    final codeUnit = username.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

@embedded
class UserBadge {
  String? iconLink;
  String? displayName;
  DateTime? creationDate;

  UserBadge({
    this.iconLink,
    this.displayName,
    this.creationDate,
  });
}

@embedded
class ProblemData {
  ProblemData({
    this.easySolved = 0,
    this.easySubmissions = 0,
    this.easyTotal = 0,
    this.mediumSolved = 0,
    this.mediumSubmissions = 0,
    this.mediumTotal = 0,
    this.hardSolved = 0,
    this.hardSubmissions = 0,
    this.hardTotal = 0,
  });

  int easySolved;
  int easyTotal;
  int easySubmissions;

  int mediumSolved;
  int mediumTotal;
  int mediumSubmissions;

  int hardSolved;
  int hardTotal;
  int hardSubmissions;

  ProblemData.fromMap(
      {required Map solvedCount, required List<AllQuestions> allCount})
      : easySolved = solvedCount['easy']['solved'],
        easySubmissions = solvedCount['easy']['submissions'],
        easyTotal = allCount
            .firstWhere((question) => question.difficulty == 'easy')
            .total,
        mediumSolved = solvedCount['medium']['solved'],
        mediumSubmissions = solvedCount['medium']['submissions'],
        mediumTotal = allCount
            .firstWhere((question) => question.difficulty == 'medium')
            .total,
        hardSolved = solvedCount['hard']['solved'],
        hardSubmissions = solvedCount['hard']['submissions'],
        hardTotal = allCount
            .firstWhere((question) => question.difficulty == 'hard')
            .total;
}

@embedded
class RecentSubmission {
  String? title;
  String? titleSlug;
  String? timestamp;
  String? id;

  RecentSubmission({
    this.id,
    this.timestamp,
    this.title,
    this.titleSlug,
  });
}

@embedded
class LanguageSubmission {
  String? languageName;
  int problemsSolved;

  LanguageSubmission({
    this.languageName,
    this.problemsSolved = 0,
  });
}

@embedded
class TagsSolved {
  String? tagName;
  String? tagSlug;
  int? problemsSolved;

  TagsSolved({
    this.tagName,
    this.tagSlug,
    this.problemsSolved,
  });
}

@embedded
class AllQuestions {
  String? difficulty;
  int total;

  AllQuestions({
    this.difficulty,
    this.total = 0,
  });
}

@embedded
class ContestRanking {
  int attendedContestsCount;
  double rating;
  int? totalParticipants;
  int globalRanking;
  double topPercentage;

  ContestRanking({
    this.attendedContestsCount = 0,
    this.rating = 0,
    this.totalParticipants,
    this.topPercentage = 100,
    this.globalRanking = 0,
  });
}

@embedded
class ContestSummary {
  int? problemsSolved;
  int totalProblems;
  int? finishTimeInSeconds;
  int? startTime;
  double? rating;
  int? ranking;
  String? title;

  ContestSummary({
    this.problemsSolved,
    this.totalProblems = 4,
    this.finishTimeInSeconds,
    this.ranking,
    this.rating,
    this.title,
    this.startTime,
  });
}

@embedded
class SubmissionCalendarDate {
  DateTime? date;
  int? submissions;

  SubmissionCalendarDate({this.date, this.submissions});
}
