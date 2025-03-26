class TestQuestion {
  final String question;
  final String questionId;
  final int xp;

  TestQuestion({required this.question, required this.questionId, required this.xp});

  @override
  String toString() {
    return 'TestQuestion(question: $question, questionId: $questionId, xp: $xp)';
  }
}
