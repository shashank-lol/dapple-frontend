part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {
  const OnboardingEvent();
}

final class GetStarted extends OnboardingEvent {}

