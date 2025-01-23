import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'option_event.dart';
part 'option_state.dart';

class OptionBloc extends Bloc<OptionEvent, OptionState> {
  OptionBloc() : super(OptionInitial(selectedOptions: [[],[],[],[],[]])) {
    on<SelectOption>((event, emit) {
      final optionIndex = event.optionIndex;
      final questionIndex = event.questionIndex;
      if(state.selectedOptions.length <= questionIndex){
        state.selectedOptions.add([optionIndex]);
      } else {
        state.selectedOptions[questionIndex].add(optionIndex);
      }
      emit(OptionSelected(selectedOptions: [...state.selectedOptions]));
    });
    on<UnSelectOption>((event, emit){
      final optionIndex = event.optionIndex;
      final questionIndex = event.questionIndex;
      state.selectedOptions[questionIndex].remove(optionIndex);
      emit(OptionSelected(selectedOptions: [...state.selectedOptions]));
    });
  }
}
