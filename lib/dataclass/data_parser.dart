import 'package:http/http.dart' as http;
import 'package:ui_elements/dataclass/query_class/query_all.dart';
import 'package:ui_elements/dataclass/query_class/user_dependent_query.dart';
import 'package:ui_elements/dataclass/query_class/user_independent_query.dart';
import 'dart:convert';
import 'dart:async';

class DataParser {
  final String username;
  DataParser({required this.username});

  Future<Map> getAllAsJson() {
    return http.get(AllQuery(username: username).getAll()).then((response) {
      var json = jsonDecode(response.body)['data'];

      Map dataMap = {};
      dataMap['username'] = username;
      dataMap['nickname'] = username;
      dataMap['recentAcSubmissionList'] = json['recentAcSubmissionList'];
      dataMap['realname'] = json['matchedUser']['profile']['realName'];
      dataMap['avatar'] = json['matchedUser']['profile']['userAvatar'];

      dataMap['badges'] = [];
      for (var badge in json['matchedUser']['badges']) {
        if (badge['icon'][0] == '/') {
          badge['icon'] = 'https://leetcode.com${badge['icon']}';
        }
        dataMap['badges'].add(badge['icon']);
      }

      dataMap['submissionStats'] = {};
      for (var category in json['matchedUser']['usernamesubmitStats']
          ['acSubmissionNum']) {
        var difficulty = category['difficulty'].toString().toLowerCase();
        var solved = category['count'];
        var submissions = category['submissions'];

        dataMap['submissionStats']
            [difficulty] = {'solved': solved, 'submissions': submissions};
      }

      dataMap['languageProblemCount'] =
          json['matchedUser']['languageProblemCount'];

      dataMap['fundamentalTagsSolved'] =
          json['matchedUser']['tagProblemCounts']['fundamental'];
      dataMap['intermediateTagsSolved'] =
          json['matchedUser']['tagProblemCounts']['intermediate'];
      dataMap['advancedTagsSolved'] =
          json['matchedUser']['tagProblemCounts']['advanced'];

      dataMap['linkedinUrl'] = json['matchedUser']['linkedinUrl'];
      dataMap['githubUrl'] = json['matchedUser']['githubUrl'];

      dataMap['userContestRanking'] = json['userContestRanking'];

      dataMap['userContestRankingHistory'] = [];
      for (var contest in json['userContestRankingHistory']) {
        if (contest['attended'] == false) continue;

        contest.remove('attended');

        contest['title'] = contest['contest']['title'];
        contest['startTime'] = contest['contest']['startTime'];
        contest.remove('contest');

        dataMap['userContestRankingHistory'].add(contest);
      }

      dataMap['dailyChallenge'] = {};
      dataMap['dailyChallenge']['title'] =
          json['activeDailyCodingChallengeQuestion']['question']['title'];
      dataMap['dailyChallenge']['difficulty'] =
          json['activeDailyCodingChallengeQuestion']['question']['difficulty'];
      dataMap['dailyChallenge']['link'] =
          'https://leetcode.com${json['activeDailyCodingChallengeQuestion']['link']}';

      dataMap['allQuestionDifficultyCount'] = {};
      for (var category in json['allQuestionsCount']) {
        var difficulty = category['difficulty'].toString().toLowerCase();
        var count = category['count'];
        dataMap['allQuestionDifficultyCount'][difficulty] = count;
      }
      return dataMap;
    });
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

  Future<List> getRecentSubmissions() {
    return http
        .get(RecentSubmissionListQuery(username: username)
            .getRecentSubmissionList())
        .then((response) =>
            jsonDecode(response.body)['data']['recentAcSubmissionList']);
  }

  Future<Map> getAcceptedSubmissionData() {
    return http
        .get(ProfileQuery(username: username).getAcceptedSubmissionsCount())
        .then((response) {
      dynamic json = jsonDecode(response.body)['data']['matchedUser']
          ['usernamesubmitStats']['acSubmissionNum'];
      Map problemData = {};

      for (var problem in json) {
        problemData[problem['difficulty']] = {
          'solved': problem['count'],
          'submissions': problem['submissions']
        };
      }

      return problemData;
    });
  }

  Future<String> getRealName() {
    return http.get(ProfileQuery(username: username).getRealName()).then(
        (response) => jsonDecode(response.body)['data']['matchedUser']
                ['profile']['realName']
            .toString());
  }

  Future<String> getAvatar() {
    return http.get(ProfileQuery(username: username).getAvatar()).then(
        (response) => jsonDecode(response.body)['data']['matchedUser']
                ['profile']['userAvatar']
            .toString());
  }

  Future<List> getBadgeIcons() {
    return http
        .get(ProfileQuery(username: username).getBadgeIcons())
        .then((response) {
      dynamic json = jsonDecode(response.body)['data']['matchedUser']['badges'];
      List links = [];
      for (var link in json) {
        String badgeLink = '';
        if (link['icon'][0] == '/') badgeLink += 'https://leetcode.com';
        links.add(badgeLink + link['icon']);
      }
      return links;
    });
  }

  Future<List> getLanguageProblemCount() {
    return http
        .get(ProfileQuery(username: username).getLanguageProblemCount())
        .then((response) {
      dynamic json = jsonDecode(response.body)['data']['matchedUser']
          ['languageProblemCount'];
      return json;
    });
  }

  Future<List> getAdvancedTagsSolved() {
    return http
        .get(ProfileQuery(username: username).getAdvancedTagsSolved())
        .then((response) {
      dynamic json = jsonDecode(response.body)['data']['matchedUser']
          ['tagProblemCounts']['advanced'];
      return json;
    });
  }

  Future<List> getIntermediateTagsSolved() {
    return http
        .get(ProfileQuery(username: username).getIntermediateTagsSolved())
        .then((response) {
      dynamic json = jsonDecode(response.body)['data']['matchedUser']
          ['tagProblemCounts']['intermediate'];
      return json;
    });
  }

  Future<List> getFundamentalTagsSolved() {
    return http
        .get(ProfileQuery(username: username).getFundamentalTagsSolved())
        .then((response) {
      dynamic json = jsonDecode(response.body)['data']['matchedUser']
          ['tagProblemCounts']['fundamental'];
      return json;
    });
  }

  Future<String> getLinkedInUrl() {
    return http.get(ProfileQuery(username: username).getLinkedInUrl()).then(
        (response) => jsonDecode(response.body)['data']['matchedUser']
                ['linkedinUrl']
            .toString());
  }

  Future<String> getGithubUrl() {
    return http.get(ProfileQuery(username: username).getGithubUrl()).then(
        (response) => jsonDecode(response.body)['data']['matchedUser']
                ['githubUrl']
            .toString());
  }

  Future<int> getContestsAttended() {
    return http
        .get(ContestRankingQuery(username: username).getContestsAttended())
        .then((response) => int.parse(jsonDecode(response.body)['data']
                ['userContestRanking']['attendedContestsCount']
            .toString()));
  }

  Future<double> getRating() {
    return http.get(ContestRankingQuery(username: username).getRating()).then(
        (response) =>
            jsonDecode(response.body)['data']['userContestRanking']['rating']);
  }

  Future<int> getTotalParticipants() {
    return http
        .get(ContestRankingQuery(username: username).getTotalParticipants())
        .then((response) => jsonDecode(response.body)['data']
            ['userContestRanking']['totalParticipants']);
  }

  Future<int> getGlobalRanking() {
    return http
        .get(ContestRankingQuery(username: username).getGlobalRanking())
        .then((response) => jsonDecode(response.body)['data']
            ['userContestRanking']['globalRanking']);
  }

  Future<double> getTopPercentage() {
    return http
        .get(ContestRankingQuery(username: username).getTopPercentage())
        .then((response) {
      dynamic json = jsonDecode(response.body)['data']['userContestRanking']
          ['topPercentage'];
      return json;
    });
  }

  Future<List> getContestHistory() {
    return http
        .get(ContestHistoryQuery(username: username).getContestHistory())
        .then(
      (response) {
        dynamic json =
            jsonDecode(response.body)['data']['userContestRankingHistory'];
        List contestData = [];

        for (var map in json) {
          if (map['attended'] == false) continue;

          map.remove('attended');
          String contestTitle = map['contest']['title'];
          int startTime = map['contest']['startTime'];
          map.remove('contest');
          map['title'] = contestTitle;
          map['startTime'] = startTime;
          contestData.add(map);
        }

        return contestData;
      },
    );
  }
}
