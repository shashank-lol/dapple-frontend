
import 'package:flutter_bloc/flutter_bloc.dart';

class XpCubit extends Cubit<int> {
  XpCubit() : super(0);
  void resetXp(int xp) => emit(xp);
  void incrementXp(int xp) => emit(state + xp);
}
