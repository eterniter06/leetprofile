class DailyQuestionQuery {
  static const String _queryEnder = '}';
  static const String _queryStarter =
      'https://leetcode.com/graphql?query=query{';
  static Uri getAll() {
    const String queryHttp = '''$_queryStarter
    activeDailyCodingChallengeQuestion{
      question{
        title
        difficulty
      }
      link
    }
    $_queryEnder''';
    return Uri.parse(queryHttp);
  }
}
