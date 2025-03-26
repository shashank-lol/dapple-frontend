part of 'test_questions_cubit.dart';

@immutable
sealed class TestQuestionsState {}

final class TestQuestionsInitial extends TestQuestionsState {}

final class TestQuestionsLoading extends TestQuestionsState {}

final class TestQuestionsError extends TestQuestionsState {
  final String message;

  TestQuestionsError(this.message);
}

final class TestQuestionsLoaded extends TestQuestionsState {
  final List<TestQuestion> questions;
  final String sessionId;
  final int currentIndex;

  TestQuestionsLoaded(this.questions, this.sessionId, this.currentIndex);
}
