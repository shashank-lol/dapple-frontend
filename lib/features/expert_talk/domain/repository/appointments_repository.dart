import 'package:dapple/features/expert_talk/data/models/meeting_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/appointment.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, List<Appointment>>> getAppointments();
// Add other methods as needed, e.g.:
Future<Either<Failure, MeetingModel>> bookAppointment(String timeSlotId);
// Future<Either<Failure, void>> cancelAppointment(String appointmentId);
}