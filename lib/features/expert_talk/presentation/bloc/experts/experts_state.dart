part of 'experts_cubit.dart';

@immutable
sealed class ExpertsState {}

final class ExpertsInitial extends ExpertsState {}

final class ExpertsLoading extends ExpertsState{}

final class ExpertsLoaded extends ExpertsState {
  final List<Expert> experts;

  ExpertsLoaded(this.experts);
}

final class ExpertsError extends ExpertsState {
  final String message;

  ExpertsError(this.message);
}
