import 'package:dapple/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dapple/core/entities/questions.dart';

import '../model/onboarding_question.dart';
import 'package:dapple/features/onboarding/data/model/option.dart' as o;

abstract interface class OnboardingQuestions {
  Either<Failure, List<OnboardingQuestion>> getQuestions();
}

class OnboardingQuestionsImpl implements OnboardingQuestions {
  @override
  Either<Failure, List<OnboardingQuestion>> getQuestions() {
    return Right([
      OnboardingQuestion(
        question: "What is your age group?",
        options: [
          o.Option(text: "<18"),
          o.Option(text: "18-24"),
          o.Option(text: "25-34"),
          o.Option(text: "35-44"),
          o.Option(text: "45+"),
        ],
        maxSelection: 1,
      ),
      OnboardingQuestion(
        question: "What is your gender?",
        options: [
          for (String option in genders) o.Option(text: option),
        ],
        maxSelection: 1,
      ),
      OnboardingQuestion(
          question: "What is your profession?",
          options: [
            for (String option in professions) o.Option(text: option),
          ],
          maxSelection: 1),
      OnboardingQuestion(
          question:
              "Which social challenges do you face most often? (Select all that apply)",
          options: [
            for (String option in challenges) o.Option(text: option),
          ],
          maxSelection: 10),
      OnboardingQuestion(
          question: "What social settings do you struggle with the most?",
          options: [
            for (String option in socialSituations) o.Option(text: option),
          ],
          maxSelection: 10),
    ]);
  }
}
