import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/features/onboarding/data/local/onboarding_questions.dart';
import 'package:dapple/features/onboarding/data/model/onboarding_question.dart';
import 'package:dapple/features/onboarding/data/model/option.dart';
import 'package:fpdart/src/either.dart';

class GetOnboardingQuestions
    implements UseCase<List<OnboardingQuestion>, Null> {
  final OnboardingQuestions onboardingQuestions;

  const GetOnboardingQuestions(this.onboardingQuestions);

  @override
  Future<Either<Failure, List<OnboardingQuestion>>> call(Null params) async {
    return Future.value(onboardingQuestions.getQuestions());
  }
}
