class AllQuery {
  final String username;
  final String _queryEnder = '}';
  final String _queryStarter = 'https://leetcode.com/graphql?query=query{';

  AllQuery({required this.username});

  Uri getAll() {
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
      badges{icon}
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
