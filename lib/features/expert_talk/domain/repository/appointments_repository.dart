import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/appointment.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, List<Appointment>>> getAppointments();
// Add other methods as needed, e.g.:
// Future<Either<Failure, void>> bookAppointment(AppointmentEntity appointment);
// Future<Either<Failure, void>> cancelAppointment(String appointmentId);
}