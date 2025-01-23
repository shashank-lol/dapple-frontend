part of 'option_bloc.dart';

@immutable
sealed class OptionState {
  final List<List<int>> selectedOptions;
  const OptionState({required this.selectedOptions});
}

final class OptionInitial extends OptionState {
  const OptionInitial({required super.selectedOptions});
}

final class OptionSelected extends OptionState{
  const OptionSelected({required super.selectedOptions});
}
