part of 'expert_schedule_cubit.dart';

@immutable
sealed class ExpertScheduleState {}

final class ExpertScheduleInitial extends ExpertScheduleState {}

final class ExpertScheduleLoading extends ExpertScheduleState {}

final class ExpertScheduleLoaded extends ExpertScheduleState {
  final List<Booking> bookings;

  ExpertScheduleLoaded({
    required this.bookings,
  });
}

final class ExpertScheduleError extends ExpertScheduleState {
  final String message;

  ExpertScheduleError({
    required this.message,
  });
}
