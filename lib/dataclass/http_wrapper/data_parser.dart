import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../query_class/user_query.dart';
import '../query_class/daily_question_query.dart';
import '../user_class/userdata.dart';

class DataParser {
  final String username;
  DataParser({required this.username});

  String _reverseDayOrder(String dayTime) {
    String day = dayTime.substring(0, 2);
    String month = dayTime.substring(3, 5);
    String year = dayTime.substring(6, 10);

    String reversedDayFormat = "$year-$month-$day";
    return dayTime.replaceFirst(dayTime.substring(0, 10), reversedDayFormat);
  }

  String _monthToNumberAsString(String month) {
    // shift to lowercase even though the standard says day names are case-sensitive anyway
    month = month.toLowerCase().trim();

    if (month == 'jan') return '01';
    if (month == 'feb') return '02';
    if (month == 'mar') return '03';
    if (month == 'apr') return '04';
    if (month == 'may') return '05';
    if (month == 'jun') return '06';
    if (month == 'jul') return '07';
    if (month == 'aug') return '08';
    if (month == 'sep') return '09';
    if (month == 'oct') return '10';
    if (month == 'nov') return '11';
    if (month == 'dec') return '12';

    throw "Month not in list. Month value passed: $month";
  }

  // HTTP date format: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Date
  // ignore: non_constant_identifier_names
  DateTime _HTTPDateToISO8601(String HTTPDate) {
    String timeWithoutDayName = HTTPDate.substring(4).trim();
    String timeWithoutGMT =
        timeWithoutDayName.substring(0, timeWithoutDayName.length - 4).trim();

    String monthInWords = timeWithoutGMT.substring(3, 7);
    String timeMonthReplacedWithNumer = timeWithoutGMT.replaceFirst(
        monthInWords, "${_monthToNumberAsString(monthInWords)} ");
    String timeFormatted = timeMonthReplacedWithNumer
        .replaceFirst(' ', '-')
        .replaceFirst(' ', '-');
    String dayOrderReveresed = _reverseDayOrder(timeFormatted);

    DateTime time = DateTime.parse("$dayOrderReveresed z").toLocal();
    return time;
  }

  Future<Map?> getAllAsJson() {
    return http.get(AllQuery.getAll(username)).then((response) {
      if (response.statusCode != 200) {
        return null;
      }

      Map responseBody = jsonDecode(response.body);

      if (responseBody.containsKey('errors')) {
        return null;
      }

      Map json = responseBody['data'];
      Map dataMap = {};

      dataMap['username'] = username;

      dataMap['realname'] = json['matchedUser']['profile']['realName'];
      dataMap['avatar'] = json['matchedUser']['profile']['userAvatar'];
      dataMap['ranking'] = json['matchedUser']['profile']['ranking'].toString();
      dataMap['reputation'] =
          json['matchedUser']['profile']['reputation'].toString();
      dataMap['solutionCount'] =
          json['matchedUser']['profile']['solutionCount'].toString();
      dataMap['postViewCount'] =
          json['matchedUser']['profile']['postViewCount'].toString();

      dataMap['lastFetchTime'] = _HTTPDateToISO8601(response.headers['date']!);

      dataMap['linkedinUrl'] = json['matchedUser']['linkedinUrl'];
      dataMap['githubUrl'] = json['matchedUser']['githubUrl'];

      _extractContestRankingHistory(json, dataMap);
      _extractLanguageSubmissions(json, dataMap);
      _extractRecentSubmissions(json, dataMap);
      _extractAllQuestionCount(json, dataMap);
      _extractSubmissionStats(json, dataMap);
      _extractContestRanking(json, dataMap);
      _extractUserCalendar(json, dataMap);
      _extractBadges(json, dataMap);

      var tagHead = json['matchedUser']['tagProblemCounts'];
      dataMap['fundamentalTagsSolved'] = _extractTags(tagHead['fundamental']);
      dataMap['intermediateTagsSolved'] = _extractTags(tagHead['intermediate']);
      dataMap['advancedTagsSolved'] = _extractTags(tagHead['advanced']);

      return dataMap;
    });
  }

  void _extractContestRankingHistory(
      Map<dynamic, dynamic> json, Map<dynamic, dynamic> dataMap) {
    dataMap['userContestRankingHistory'] = <ContestSummary>[];
    for (var contest in json['userContestRankingHistory']) {
      if (contest['attended'] == false) continue;

      contest['title'] = contest['contest']['title'];
      contest['startTime'] = contest['contest']['startTime'];
      contest.remove('contest');

      dataMap['userContestRankingHistory'].add(ContestSummary(
        problemsSolved: contest['problemsSolved'],
        finishTimeInSeconds: contest['finishTimeInSeconds'],
        ranking: contest['ranking'],
        rating: contest['rating'],
        startTime: contest['startTime'],
        title: contest['title'],
        totalProblems: contest['totalProblems'],
      ));
    }
  }

  void _extractContestRanking(
      Map<dynamic, dynamic> json, Map<dynamic, dynamic> dataMap) {
    var ranking = json['userContestRanking'];
    if (ranking == null || ranking == 'null') {
      dataMap['userContestRanking'] = null;
      return;
    }
    var rankingObject = ContestRanking(
      attendedContestsCount: ranking['attendedContestsCount'],
      globalRanking: ranking['globalRanking'],
      rating: ranking['rating'],
      topPercentage: ranking['topPercentage'],
      totalParticipants: ranking['totalParticipants'],
    );
    dataMap['userContestRanking'] = rankingObject;
  }

  void _extractAllQuestionCount(
      Map<dynamic, dynamic> json, Map<dynamic, dynamic> dataMap) {
    dataMap['allQuestionDifficultyCount'] = <AllQuestions>[];
    for (var category in json['allQuestionsCount']) {
      var difficulty = category['difficulty'].toString().toLowerCase();
      var count = category['count'];
      dataMap['allQuestionDifficultyCount'].add(
        AllQuestions(
          difficulty: difficulty,
          total: count,
        ),
      );
    }
  }

  List<TagsSolved> _extractTags(tagHead) {
    List<TagsSolved> tagList = [];
    for (var tag in tagHead) {
      tagList.add(TagsSolved(
        problemsSolved: tag['problemsSolved'],
        tagName: tag['tagName'],
        tagSlug: tag['tagSlug'],
      ));
    }

    tagList.sort((TagsSolved lhs, TagsSolved rhs) =>
        rhs.problemsSolved!.compareTo(lhs.problemsSolved!));
    return tagList;
  }

  void _extractRecentSubmissions(
      Map<dynamic, dynamic> json, Map<dynamic, dynamic> dataMap) {
    var subList = json['recentAcSubmissionList'];
    List<RecentSubmission> recentSubmissionList = [];
    for (var submission in subList) {
      recentSubmissionList.add(RecentSubmission(
        title: submission['title'],
        id: submission['id'],
        titleSlug: submission['titleSlug'],
        epochInSeconds: submission['timestamp'],
      ));
    }
    dataMap['recentAcSubmissionList'] = recentSubmissionList;
  }

  void _extractLanguageSubmissions(
      Map<dynamic, dynamic> json, Map<dynamic, dynamic> dataMap) {
    List<LanguageSubmission> languageSubmissions = [];
    for (var languageSub in json['matchedUser']['languageProblemCount']) {
      languageSubmissions.add(LanguageSubmission(
        languageName: languageSub['languageName'],
        problemsSolved: languageSub['problemsSolved'],
      ));
    }
    languageSubmissions.sort((LanguageSubmission lhs, LanguageSubmission rhs) =>
        rhs.problemsSolved.compareTo(lhs.problemsSolved));

    dataMap['languageProblemCount'] = languageSubmissions;
  }

  void _extractSubmissionStats(
      Map<dynamic, dynamic> json, Map<dynamic, dynamic> dataMap) {
    dataMap['submissionStats'] = {};
    for (var category in json['matchedUser']['usernamesubmitStats']
        ['acSubmissionNum']) {
      var difficulty = category['difficulty'].toString().toLowerCase();
      var solved = category['count'];
      var submissions = category['submissions'];

      dataMap['submissionStats']
          [difficulty] = {'solved': solved, 'submissions': submissions};
    }
  }

  void _extractBadges(
      Map<dynamic, dynamic> json, Map<dynamic, dynamic> dataMap) {
    dataMap['badges'] = <UserBadge>[];

    for (var badge in json['matchedUser']['badges']) {
      if (badge['icon'][0] == '/') {
        badge['icon'] = 'https://leetcode.com${badge['icon']}';
      }

      String icon = badge['icon'];
      String displayName = badge['displayName'];
      String creationDate = badge['creationDate'];

      DateTime creationDateAsDateTime = DateTime.parse(creationDate);

      UserBadge obtainedBadge = UserBadge(
          iconLink: icon,
          displayName: displayName,
          creationDate: creationDateAsDateTime);

      dataMap['badges'].add(obtainedBadge);
    }
  }

  void _extractUserCalendar(
      Map<dynamic, dynamic> json, Map<dynamic, dynamic> dataMap) {
    var calendar = json['matchedUser']['userCalendar'];

    Map<String, dynamic> submissions =
        jsonDecode(calendar['submissionCalendar']);

    List<SubmissionCalendarDate> submissionList = [];

    for (String epoch in submissions.keys) {
      int count = submissions[epoch];
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(int.parse(epoch) * 1000);

      SubmissionCalendarDate sub =
          SubmissionCalendarDate(date: date, submissions: count);

      submissionList.add(sub);
    }
    dataMap['totalActiveDays'] = calendar['totalActiveDays'];
    dataMap['submissionCalendar'] = submissionList;
  }

  static Future<DailyQuestion> getDailyQuestion() async {
    http.Response response = await http.get(DailyQuestionQuery.getAll());

    dynamic header =
        jsonDecode(response.body)['data']['activeDailyCodingChallengeQuestion'];

    final String difficulty = header['question']['difficulty'];
    final String title = header['question']['title'];
    final String link = header['link'];

    return DailyQuestion(
      difficulty: difficulty,
      title: title,
      link: link,
    );
  }
}

class DailyQuestion {
  String? link;
  String? title;
  String? difficulty;

  DailyQuestion({
    this.link,
    this.title,
    this.difficulty,
  });
}
