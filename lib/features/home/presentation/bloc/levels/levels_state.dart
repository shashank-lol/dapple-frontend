part of 'levels_cubit.dart';

@immutable
sealed class LevelsState {}

final class LevelsInitial extends LevelsState {}

final class LevelsLoading extends LevelsState{}

final class LevelsFailure extends LevelsState{
  final String message;

  LevelsFailure(this.message);

  @override
  String toString() {
    return 'LevelsFailure{message: $message}';
  }
}

final class LevelsLoaded extends LevelsState{
  final LevelSectionWrapper levelAndSection;

  LevelsLoaded(this.levelAndSection);
}
