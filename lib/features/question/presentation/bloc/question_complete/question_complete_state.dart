part of 'question_complete_bloc.dart';

@immutable
sealed class QuestionCompleteState {}

final class QuestionCompleteInitial extends QuestionCompleteState {}

final class CompletionLoading extends QuestionCompleteState {}

final class QuestionCompleteError extends QuestionCompleteState {
  final String message;

  QuestionCompleteError(this.message);
}

final class LessonCompleted extends QuestionCompleteState{}

final class ObjectiveAnswered extends QuestionCompleteState{
  final bool isCorrect;
  final ObjectiveQuestionAnswer objectiveQuestionAnswer;
  final int xp;

  ObjectiveAnswered(this.isCorrect, this.objectiveQuestionAnswer, this.xp);
}

final class SubjectiveAnswered extends QuestionCompleteState{
  final SubjectiveQuestionAnswer subjectiveQuestionAnswer;
  final int maxXp;

  SubjectiveAnswered(this.subjectiveQuestionAnswer, this.maxXp);
}

final class SubjectiveAnswerHint extends QuestionCompleteState{
  final String hint;

  SubjectiveAnswerHint(this.hint);
}
