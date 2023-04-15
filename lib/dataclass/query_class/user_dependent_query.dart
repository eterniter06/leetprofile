class RecentSubmissionListQuery {
  final String username;
  final String _queryEnder = '}';
  final String _queryStarter;

  RecentSubmissionListQuery({required this.username})
      : _queryStarter =
            'https://leetcode.com/graphql?query=query{recentAcSubmissionList(username: "$username") {title timestamp}';

  Uri getRecentSubmissionList() {
    return Uri.parse(_queryStarter + _queryEnder);
  }
}

class ProfileQuery {
  final String username;
  final String _queryStarter;
  ProfileQuery({required this.username})
      : _queryStarter =
            'https://leetcode.com/graphql?query=query{matchedUser(username: "$username"){';

  final String _queryEnder = '}}';

  Uri getAcceptedSubmissionsCount() {
    final String queryHttp = '''$_queryStarter
      usernamesubmitStats:submitStatsGlobal{
        acSubmissionNum{
          difficulty
          count
          submissions
        }
      }
      $_queryEnder''';
    return Uri.parse(queryHttp);
  }

  Uri getRealName() {
    final String queryHttp = '${_queryStarter}profile{realName}$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getAvatar() {
    // Default dimensions are 96px x 96px
    final String queryHttp = '${_queryStarter}profile{userAvatar}$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getBadgeIcons() {
    final String queryHttp = '${_queryStarter}badges{icon}$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getLanguageProblemCount() {
    final String queryHttp =
        '${_queryStarter}languageProblemCount{languageName problemsSolved}$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getAdvancedTagsSolved() {
    final String queryHttp =
        '${_queryStarter}tagProblemCounts{advanced{tagName tagSlug problemsSolved}}$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getIntermediateTagsSolved() {
    final String queryHttp =
        '${_queryStarter}tagProblemCounts{intermediate{tagName tagSlug problemsSolved}}$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getFundamentalTagsSolved() {
    final String queryHttp =
        '${_queryStarter}tagProblemCounts{fundamental{tagName tagSlug problemsSolved}}$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getLinkedInUrl() {
    final String queryHttp = '${_queryStarter}linkedinUrl$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getGithubUrl() {
    final String queryHttp = '${_queryStarter}githubUrl$_queryEnder';
    return Uri.parse(queryHttp);
  }
}

class ContestRankingQuery {
  final String username;
  final String _queryStarter;
  final String _queryEnder = '}}';

  ContestRankingQuery({required this.username})
      : _queryStarter =
            'https://leetcode.com/graphql?query=query{userContestRanking(username: "$username"){';

  Uri getContestsAttended() {
    final String queryHttp =
        '${_queryStarter}attendedContestsCount$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getRating() {
    final String queryHttp = '${_queryStarter}rating$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getTotalParticipants() {
    final String queryHttp = '${_queryStarter}totalParticipants$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getGlobalRanking() {
    final String queryHttp = '${_queryStarter}globalRanking$_queryEnder';
    return Uri.parse(queryHttp);
  }

  Uri getTopPercentage() {
    final String queryHttp = '${_queryStarter}topPercentage$_queryEnder';
    return Uri.parse(queryHttp);
  }
}

class ContestHistoryQuery {
  final String username;
  final String _queryStarter;
  final String _queryEnder = '}}';

  ContestHistoryQuery({required this.username})
      : _queryStarter =
            'https://leetcode.com/graphql?query=query{userContestRankingHistory(username:"$username"){';

  Uri getContestHistory() {
    final String queryHttp =
        '${_queryStarter}attended problemsSolved totalProblems finishTimeInSeconds rating ranking contest{title startTime}$_queryEnder';
    return Uri.parse(queryHttp);
  }
}
