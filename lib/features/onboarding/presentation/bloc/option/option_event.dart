part of 'option_bloc.dart';

@immutable
sealed class OptionEvent {
  const OptionEvent();
}

final class SelectOption extends OptionEvent {
  final int questionIndex;
  final int optionIndex;

  const SelectOption({required this.questionIndex, required this.optionIndex});
}

final class UnSelectOption extends OptionEvent {
  final int questionIndex;
  final int optionIndex;

  const UnSelectOption({
    required this.questionIndex,
    required this.optionIndex,
  });
}
