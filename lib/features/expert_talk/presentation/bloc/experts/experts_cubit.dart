import 'package:dapple/core/usecase/usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/expert.dart';
import '../../../domain/usecases/get_experts.dart';

part 'experts_state.dart';

class ExpertsCubit extends Cubit<ExpertsState> {
  final GetAllExperts _getAllExperts;

  ExpertsCubit({required GetAllExperts getAllExperts})
      : _getAllExperts = getAllExperts,
        super(ExpertsInitial());

  Future<void> loadExperts() async {
    emit(ExpertsLoading());
    final res = await _getAllExperts(NoParams());
    res.fold((l) {
      emit(ExpertsError(l.message));
    }, (experts) {
      emit(ExpertsLoaded(experts));
    });
  }
}
