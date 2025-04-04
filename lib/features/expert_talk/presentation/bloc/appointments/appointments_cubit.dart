import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/appointment.dart';
import '../../../domain/usecases/get_appointments.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final GetAllAppointments _getAllAppointments;

  AppointmentsCubit({required GetAllAppointments getAllAppointments})
      : _getAllAppointments = getAllAppointments,
        super(AppointmentsInitial());

  Future<void> loadAppointments() async {
    emit(AppointmentsLoading());
    final res = await _getAllAppointments(NoParams());
    res.fold(
      (failure) {
        emit(AppointmentsError(failure.message));
      },
      (appointments) {
        emit(AppointmentsLoaded(appointments));
      },
    );
  }
}
