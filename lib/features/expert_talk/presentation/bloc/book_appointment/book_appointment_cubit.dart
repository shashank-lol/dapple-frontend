import 'package:dapple/features/expert_talk/domain/entities/meeting.dart';
import 'package:dapple/features/expert_talk/domain/usecases/book_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_appointment_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  final BookAppointment _bookAppointment;

  BookAppointmentCubit({required BookAppointment bookAppointment})
      : _bookAppointment = bookAppointment,
        super(BookAppointmentInitial());

  Future<void> bookNewAppointment(String timeSlotId) async {
    debugPrint('Booking appointment with time slot ID: $timeSlotId');
    emit(AppointmentLoading()); // Optionally show loading while booking

    final result = await _bookAppointment(timeSlotId);
    debugPrint('Booking result: $result');

    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (meeting) {
        // Get current state to preserve existing appointments
        emit(AppointmentBooked(meeting));
      },
    );
  }
}
