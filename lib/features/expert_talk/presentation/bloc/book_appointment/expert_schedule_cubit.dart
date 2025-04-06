import 'package:dapple/features/expert_talk/domain/entities/time_slot.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/booking.dart';
import '../../../domain/usecases/get_expert_schedule.dart';

part 'expert_schedule_state.dart';

class ExpertScheduleCubit extends Cubit<ExpertScheduleState> {
  final GetExpertSchedule _getExpertSchedule;

  ExpertScheduleCubit({required GetExpertSchedule getExpertSchedule})
      : _getExpertSchedule = getExpertSchedule,
        super(ExpertScheduleInitial());

  Future<void> loadSchedule(String expertId) async {
    emit(ExpertScheduleLoading());
    final result = await _getExpertSchedule(expertId);
    result.fold(
      (failure) {
        emit(ExpertScheduleError(message: failure.message));
      },
      (schedule) {
        emit(ExpertScheduleLoaded(bookings: schedule));
      },
    );
  }

  List<TimeSlot> getScheduleByDate(DateTime date) {
    if (state is ExpertScheduleLoaded) {
      print(date.toString());
      final bookings = (state as ExpertScheduleLoaded).bookings;
      final Booking booking = bookings.firstWhere(
        (booking) => booking.date.year == date.year && booking.date.month == date.month && booking.date.day == date.day,
      );
      return booking.timeSlots;
    }
    return [];
  }
}
