part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {
  const OnboardingState();
}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingSelected extends OnboardingState {
  final List<OnboardingQuestion> questions;

  const OnboardingSelected({required this.questions});

  @override
  String toString() {
    return 'OnboardingSelected{questions: $questions}';
  }
}

final class OnboardingFailure extends OnboardingState {
  final String message;

  const OnboardingFailure(this.message);
}


