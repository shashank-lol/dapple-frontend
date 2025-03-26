import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/features/home/domain/usecases/update_xp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class XpCubit extends Cubit<int> {
  final UpdateXp _updateXp;

  XpCubit(UpdateXp updateXp)
      : _updateXp = updateXp,
        super(0);

  void resetXp(int xp) => emit(xp);

  void incrementXp(int xp) => emit(state + xp);

  void updateXpFromServer() async => await _updateXp(NoParams());
}
