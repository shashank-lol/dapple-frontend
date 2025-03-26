part of 'question_complete_bloc.dart';

@immutable
sealed class QuestionCompleteEvent {}

final class LessonCompletedEvent extends QuestionCompleteEvent {
  final String lessonId;

  LessonCompletedEvent(this.lessonId);
}

final class ObjectiveAnsweredEvent extends QuestionCompleteEvent {
  final int objectiveIndex;
  final String questionId;

  ObjectiveAnsweredEvent(this.objectiveIndex, this.questionId);
}

final class SubjectiveAnsweredEvent extends QuestionCompleteEvent {
  final List<String> answer;
  final String questionId;
  final int maxXp;

  SubjectiveAnsweredEvent(this.answer, this.questionId, this.maxXp);
}

final class SubjectiveAnswerHintEvent extends QuestionCompleteEvent {
  final String questionId;

  SubjectiveAnswerHintEvent(this.questionId);
}

final class VoiceAnsweredEvent extends QuestionCompleteEvent {
  final File audioFile;
  final String questionId;
  final int maxXp;

  VoiceAnsweredEvent(this.audioFile, this.questionId, this.maxXp);
}

final class QuestionResetEvent extends QuestionCompleteEvent {}
