import 'package:dapple/features/home/domain/usecases/update_xp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecase/usecase.dart';

class XpServerCubit extends Cubit<int> {
  UpdateXp _updateXp;

  XpServerCubit({required UpdateXp updateXp})
      : _updateXp = updateXp,
        super(0);

  void updateXpFromServer() {
    _updateXp(NoParams()).then((value) {
      emit(value.getOrElse((f) => 0));
    });
  }
}
