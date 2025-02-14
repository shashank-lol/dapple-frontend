class Question{
  final String questionId;
  final int xp;
  final String? questionType;
  final String? question;
  final String? title;

  Question({
    required this.questionId,
    required this.xp,
    this.questionType,
    this.question,
    this.title,
  });

  @override
  String toString() {
    return 'Question{questionId: $questionId, xp: $xp, questionType: $questionType, question: $question, title: $title}';
  }
}