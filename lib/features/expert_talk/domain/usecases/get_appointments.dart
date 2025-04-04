import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/appointment.dart';
import '../repository/appointments_repository.dart';

class GetAllAppointments implements UseCase<List<Appointment>, NoParams> {
  final AppointmentRepository repository;

  GetAllAppointments(this.repository);

  @override
  Future<Either<Failure, List<Appointment>>> call(NoParams params) async {
    return await repository.getAppointments();
  }
}