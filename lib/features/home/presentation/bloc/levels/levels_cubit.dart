import 'package:dapple/features/home/data/models/level_section_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/get_all_levels.dart';

part 'levels_state.dart';

class LevelsCubit extends Cubit<LevelsState> {
  final GetAllLevels _getAllLevels;

  LevelsCubit({required GetAllLevels getAllLevels})
      : _getAllLevels = getAllLevels,
        super(LevelsInitial());

  void loadLevels() async {
    emit(LevelsLoading());
    await _getAllLevels(NoParams()).then(
      (result) => result.fold(
        (failure) => emit(LevelsFailure(failure.message)),
        (levels) => emit(LevelsLoaded(levels)),
      ),
    );
    debugPrint(state.toString());
  }
}
