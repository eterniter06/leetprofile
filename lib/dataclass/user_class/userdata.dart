import 'dart:math';

import 'package:isar/isar.dart';
part 'userdata.g.dart';

@collection
class UserData {
  Id get isarId => fastHash(username);

  // User given data
  late String? nickname;
  int? listOrder;

  // Server fetched data
  final String username;
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

    // Todo: Figure out why this is here and it's effect
    // listOrder = updatedUser.listOrder;

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
    required this.avatar,
    required this.realname,
    required this.lastFetchTime,
    this.totalActiveDays = 0,
    this.postViewCount = '0',
    this.solutionCount = '0',
    this.reputation = '0',
    this.ranking = '-1',
    this.nickname,
    this.advancedTags,
    this.allQuestionsCount,
    this.badges,
    this.fundamentalTags,
    this.githubUrl,
    this.intermediateTags,
    this.languageProblemCount,
    this.linkedinUrl,
    this.listOrder,
    this.problemData,
    this.recentAcSubmissionList,
    this.submissionActivity,
    this.userContestRanking,
    this.userContestRankingHistory,
  });

  /// Assets used must not contain 'http' anywhere in their name.
  /// Whether the full asset name contains 'http' is the criteria to
  /// load a network (usually cached) image vs an asset image
  static UserData dummyUser = UserData(
    username: 'User',
    avatar: 'assets/default_avatar.png',
    realname: 'User user',
    lastFetchTime: DateTime.now(),
    nickname: 'Eternity',
    totalActiveDays: 100,
    listOrder: 0,
    postViewCount: '42',
    ranking: '007',
    solutionCount: '666',
    reputation: '99',
    submissionActivity: <SubmissionCalendarDate>[
      SubmissionCalendarDate(
        date: DateTime.now(),
        submissions: 666,
      ),
      SubmissionCalendarDate(
        date: DateTime.now().copyWith(day: DateTime.now().day - 1),
        submissions: 1,
      )
    ],
    badges: <UserBadge>[
      UserBadge(
          creationDate: DateTime.now(),
          displayName: 'Procrastinator',
          iconLink: 'assets/image.jpg')
    ],
    githubUrl: 'guthib.com',
    linkedinUrl: 'linkedin.com',
    languageProblemCount: <LanguageSubmission>[
      LanguageSubmission(languageName: 'Miau', problemsSolved: 20),
      LanguageSubmission(languageName: 'Bork bork', problemsSolved: 18),
    ],
    recentAcSubmissionList: <RecentSubmission>[
      RecentSubmission(
          id: '1',
          epochInSeconds: (DateTime.now()
                      .copyWith(day: Random().nextInt(7) + 3)
                      .millisecondsSinceEpoch /
                  1000)
              .truncate()
              .toString(),
          title: 'Definitely'),
      RecentSubmission(
          id: '2',
          epochInSeconds: (DateTime.now()
                      .copyWith(day: Random().nextInt(6) - 3)
                      .millisecondsSinceEpoch /
                  1000)
              .truncate()
              .toString(),
          title: 'Yeeee'),
      RecentSubmission(
          id: '3',
          epochInSeconds: (DateTime.now().millisecondsSinceEpoch / 1000)
              .truncate()
              .toString(),
          title: 'Answer'),
    ],
    userContestRanking: ContestRanking(
        attendedContestsCount: -43,
        globalRanking: -3,
        rating: 99999,
        topPercentage: 123.5,
        totalParticipants: -9),
    userContestRankingHistory: <ContestSummary>[
      ContestSummary(
        problemsSolved: 1,
        finishTimeInSeconds: 68,
        ranking: 2,
        rating: -1234,
        startTime: (DateTime.now().millisecondsSinceEpoch / 1000).truncate(),
        title: 'Kontest',
        totalProblems: -5,
      ),
      ContestSummary(
        problemsSolved: 100,
        finishTimeInSeconds: 1,
        ranking: -34,
        rating: -1234,
        startTime:
            (DateTime.now().copyWith(day: -1).millisecondsSinceEpoch / 1000)
                .truncate(),
        title: 'Kawntest',
        totalProblems: 902,
      ),
      ContestSummary(
        problemsSolved: 2,
        finishTimeInSeconds: 90,
        ranking: -89,
        rating: -1234,
        startTime:
            (DateTime.now().copyWith(day: -2).millisecondsSinceEpoch / 1000)
                .truncate(),
        title: 'Crontest',
        totalProblems: 473,
      ),
    ],
    allQuestionsCount: <AllQuestions>[
      AllQuestions(difficulty: 'Asian', total: 50),
      AllQuestions(difficulty: 'Normal', total: 400),
      AllQuestions(difficulty: 'Breakfast', total: 150),
    ],
    problemData: ProblemData(
      easySolved: 100,
      easySubmissions: 120,
      easyTotal: 150,
      hardSolved: 5,
      hardSubmissions: 15,
      hardTotal: 50,
      mediumSolved: 50,
      mediumSubmissions: 60,
      mediumTotal: 400,
    ),
    fundamentalTags: List<TagsSolved>.generate(
      10,
      (index) => TagsSolved(
        tagName: 'Ez pz #$index',
        problemsSolved: 100 + index * Random().nextInt(100),
      ),
    ),
    intermediateTags: List<TagsSolved>.generate(
      10,
      (index) => TagsSolved(
        tagName: 'Okie dokie #${index - 2 + 6}',
        problemsSolved: 10 - index + 6,
      ),
    ),
    advancedTags: List<TagsSolved>.generate(
      10,
      (index) => TagsSolved(
        tagName:
            '*Sweats profusely* #${index * -1 + 2 + Random().nextInt(10) - 7}',
        problemsSolved: 10 - index - 1,
      ),
    ),
  );

  UserData.fromMap({required Map dataMap, String? nickname})
      : username = dataMap['username'],
        nickname = nickname ?? dataMap['nickname'],
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
  String? epochInSeconds;
  String? id;

  RecentSubmission({
    this.id,
    this.epochInSeconds,
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
