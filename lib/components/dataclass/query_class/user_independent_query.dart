class DailyQuestionQuery {
  static const String _queryStarter =
      r'https://leetcode.com/graphql?query=query{activeDailyCodingChallengeQuestion{';
  static const String _queryEnder = r'}}';

  static Uri getDailyQuestionTitle() {
    const String queryHttp = '${_queryStarter}question{title}$_queryEnder';
    return Uri.parse(queryHttp);
  }

  static Uri getDailyQuestionDifficulty() {
    const String queryHttp = '${_queryStarter}question{difficulty}$_queryEnder';
    return Uri.parse(queryHttp);
  }

  static Uri getDailyQuestionLink() {
    const String queryHttp = '${_queryStarter}link$_queryEnder';
    return Uri.parse(queryHttp);
  }
}

class AllQuestionCountQuery {
  static const String _queryStarter =
      'https://leetcode.com/graphql?query=query{allQuestionsCount{difficulty count';
  static const String _queryEnder = '}}';

  static Uri getTotalQuestionCount() {
    return Uri.parse('$_queryStarter$_queryEnder');
  }
}
