import 'package:dapple/core/error/failure.dart';
import 'package:flutter/material.dart';
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
        question: "What do you want to improve upon",
        options: [
          o.Option(text: options[0], icon: Icons.fitness_center),
          o.Option(text: options[1], icon: Icons.self_improvement),
          o.Option(text: options[2], icon: Icons.work),
        ],
        maxSelection: 3,
      ),
      OnboardingQuestion(
        question: "What is your age?",
        options: [
          o.Option(text: "18-25"),
          o.Option(text: "26-35"),
          o.Option(text: "36-45"),
          o.Option(text: "46+"),
        ],
        maxSelection: 1,
      ),
    ]);
  }
}
