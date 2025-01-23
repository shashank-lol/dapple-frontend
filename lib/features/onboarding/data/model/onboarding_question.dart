import 'option.dart';

class OnboardingQuestion{
  final String question;
  final List<Option> options;
  final int maxSelection;

  OnboardingQuestion({required this.question, required this.options, required this.maxSelection});
}
