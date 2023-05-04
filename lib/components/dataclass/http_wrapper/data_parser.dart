import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../query_class/query_all.dart';
import '../query_class/user_independent_query.dart';
import '../user_class/userdata.dart';

class DataParser {
  final String username;
  DataParser({required this.username});

  Future<Map?> getAllAsJson() {
    return http.get(AllQuery(username: username).getAll()).then((response) {
      if (response.statusCode != 200) {
        return null;
      }

      Map responseBody = jsonDecode(response.body);

      if (responseBody.containsKey('errors')) {
        return null;
      }

      Map json = responseBody['data'];

      Map dataMap = {};

      dataMap['username'] = dataMap['nickname'] = username;
      dataMap['realname'] = json['matchedUser']['profile']['realName'];
      dataMap['avatar'] = json['matchedUser']['profile']['userAvatar'];

      dataMap['linkedinUrl'] = json['matchedUser']['linkedinUrl'];
      dataMap['githubUrl'] = json['matchedUser']['githubUrl'];

      _extractBadges(dataMap, json);
      _extractSubmissionStats(dataMap, json);
      _extractLanguageSubmissions(json, dataMap);
      _extractRecentSubmissions(json, dataMap);
      _extractAllQuestionCount(dataMap, json);
      _extractContestRanking(json, dataMap);
      _extractContestRankingHistory(dataMap, json);

      var tagHead = json['matchedUser']['tagProblemCounts'];
      dataMap['fundamentalTagsSolved'] = _extractTags(tagHead['fundamental']);
      dataMap['intermediateTagsSolved'] = _extractTags(tagHead['intermediate']);
      dataMap['advancedTagsSolved'] = _extractTags(tagHead['advanced']);

      return dataMap;
    });
  }

  void _extractContestRankingHistory(
      Map<dynamic, dynamic> dataMap, Map<dynamic, dynamic> json) {
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
      Map<dynamic, dynamic> dataMap, Map<dynamic, dynamic> json) {
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
        timestamp: submission['timestamp'],
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
    dataMap['languageProblemCount'] = languageSubmissions;
  }

  void _extractSubmissionStats(
      Map<dynamic, dynamic> dataMap, Map<dynamic, dynamic> json) {
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
      Map<dynamic, dynamic> dataMap, Map<dynamic, dynamic> json) {
    dataMap['badges'] = <String>[];
    for (var badge in json['matchedUser']['badges']) {
      if (badge['icon'][0] == '/') {
        badge['icon'] = 'https://leetcode.com${badge['icon']}';
      }
      dataMap['badges'].add(badge['icon']);
    }
  }

  static Future<DailyQuestion> getDailyQuestion() async {
    return DailyQuestion(
      difficulty: await getDailyQuestionDifficulty(),
      link: await getDailyQuestionLink(),
      title: await getDailyQuestionTitle(),
    );
  }

  static Future<String> getDailyQuestionTitle() {
    return http.get(DailyQuestionQuery.getDailyQuestionTitle()).then(
        (response) => jsonDecode(response.body)['data']
                ['activeDailyCodingChallengeQuestion']['question']['title']
            .toString());
  }

  static Future<String> getDailyQuestionLink() {
    return http.get(DailyQuestionQuery.getDailyQuestionLink()).then(
        (response) => jsonDecode(response.body)['data']
                ['activeDailyCodingChallengeQuestion']['link']
            .toString());
  }

  static Future<String> getDailyQuestionDifficulty() {
    return http.get(DailyQuestionQuery.getDailyQuestionDifficulty()).then(
        (response) => jsonDecode(response.body)['data']
                ['activeDailyCodingChallengeQuestion']['question']['difficulty']
            .toString());
  }

  static Future<Map> getTotalQuestionCount() {
    return http.get(AllQuestionCountQuery.getTotalQuestionCount()).then(
      (response) {
        dynamic json = jsonDecode(response.body)['data']['allQuestionsCount'];
        Map problemMap = {};
        for (var map in json) {
          problemMap[map['difficulty'].toString().toLowerCase()] = map['count'];
        }

        return problemMap;
      },
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
