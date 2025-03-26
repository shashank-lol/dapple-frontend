class TestSummary{
  final String title;
  final String content;
  final int userScore;
  final int totalScore;

  TestSummary(this.title, this.content, this.userScore, this.totalScore);

  @override
  String toString() {
    return 'TestSummary(title: $title, content: $content, userScore: $userScore, totalScore: $totalScore)';
  }
}