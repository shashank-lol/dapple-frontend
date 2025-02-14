part of 'questions_cubit.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}

final class QuestionsLoading extends QuestionsState {}

final class QuestionsLoaded extends QuestionsState {
  final List<dynamic> questions;
  final int currentIndex;

  QuestionsLoaded(this.questions, this.currentIndex);
}

final class QuestionsError extends QuestionsState {
  final String message;

  QuestionsError(this.message);
}
