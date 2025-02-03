part of 'option_bloc.dart';

@immutable
sealed class OptionEvent {
  final int maxSelection;

  const OptionEvent({required this.maxSelection});
}

final class SelectOption extends OptionEvent {
  final int questionIndex;
  final int optionIndex;

  const SelectOption(
      {required super.maxSelection,
      required this.questionIndex,
      required this.optionIndex});
}

final class UnSelectOption extends OptionEvent {
  final int questionIndex;
  final int optionIndex;

  const UnSelectOption({
    required super.maxSelection,
    required this.questionIndex,
    required this.optionIndex,
  });
}
