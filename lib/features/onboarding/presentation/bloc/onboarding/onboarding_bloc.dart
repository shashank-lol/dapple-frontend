import 'package:dapple/features/onboarding/domain/usecases/get_onboarding_questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/model/onboarding_question.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetOnboardingQuestions _getOnboardingQuestions;

  OnboardingBloc({required GetOnboardingQuestions getOnboardingQuestions})
    : _getOnboardingQuestions = getOnboardingQuestions,
      super(OnboardingInitial()) {
    on<GetStarted>((event, emit) async {
      final questions = await _getOnboardingQuestions(null);
      questions.fold(
        (l) => emit(OnboardingFailure(l.message)),
        (r) => emit(OnboardingSelected(questions: r)),
      );
    });
  }

}
