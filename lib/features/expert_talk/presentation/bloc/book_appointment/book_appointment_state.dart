part of 'book_appointment_cubit.dart';

@immutable
sealed class BookAppointmentState {}

final class BookAppointmentInitial extends BookAppointmentState {}

final class AppointmentLoading extends BookAppointmentState {}

final class AppointmentBooked extends BookAppointmentState {
  final Meeting meeting;

  AppointmentBooked(this.meeting);
}

final class AppointmentError extends BookAppointmentState {
  final String errorMessage;

  AppointmentError(this.errorMessage);
}
