part of 'result_cubit.dart';

@immutable
sealed class ResultState {}

final class ResultInitial extends ResultState {}

final class ResultLoading extends ResultState {}

final class ResultError extends ResultState {
  final String message;

  ResultError(this.message);
}

final class ResultLoaded extends ResultState {
  final TestResult testResult;

  ResultLoaded(this.testResult);
}
