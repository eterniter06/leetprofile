class ProblemData {
  int easySolved;
  int easyTotal;
  int easySubmissions;

  int mediumSolved;
  int mediumTotal;
  int mediumSubmissions;

  int hardSolved;
  int hardTotal;
  int hardSubmissions;

  ProblemData.fromMap({required Map solvedCount, required Map allCount})
      : easySolved = solvedCount['easy']['solved'],
        easySubmissions = solvedCount['easy']['submissions'],
        easyTotal = allCount['easy'],
        mediumSolved = solvedCount['medium']['solved'],
        mediumSubmissions = solvedCount['medium']['submissions'],
        mediumTotal = allCount['medium'],
        hardSolved = solvedCount['hard']['solved'],
        hardSubmissions = solvedCount['hard']['submissions'],
        hardTotal = allCount['hard'];
}
