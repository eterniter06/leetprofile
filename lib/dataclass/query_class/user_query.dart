class AllQuery {
  static const String _queryEnder = '}';
  static const String _queryStarter =
      'https://leetcode.com/graphql?query=query{';

  static Uri getAll(String username) {
    final String queryHttp = '''$_queryStarter
    recentAcSubmissionList(username: "$username") {title titleSlug id timestamp}
    matchedUser(username: "$username"){
      usernamesubmitStats:submitStatsGlobal{
        acSubmissionNum{
          difficulty
          count
          submissions
        }
      }
      profile{
        realName
        userAvatar
        ranking
        reputation
        solutionCount
        postViewCount
      }
      badges{
        icon
        creationDate
        displayName
      }
      languageProblemCount{
        languageName
        problemsSolved
      }
      tagProblemCounts{
        fundamental{tagName tagSlug problemsSolved}
        intermediate{tagName tagSlug problemsSolved}
        advanced{tagName tagSlug problemsSolved}
      }
      linkedinUrl
      githubUrl
    }
    userContestRanking(username: "$username"){
      attendedContestsCount
      rating
      totalParticipants
      globalRanking
      topPercentage
    }
    userContestRankingHistory(username: "$username"){
      attended
      problemsSolved
      totalProblems
      finishTimeInSeconds
      rating
      ranking
      contest{
        title
        startTime
      }
    }
    activeDailyCodingChallengeQuestion{
      question{
        title
        difficulty
      }
      link
    }
    allQuestionsCount{
      difficulty
      count
    }
    $_queryEnder''';
    return Uri.parse(queryHttp);
  }
}
