import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/meeting_model.dart';
import '../repository/appointments_repository.dart';

class BookAppointment implements UseCase<MeetingModel, String> {
  final AppointmentRepository repository;

  BookAppointment(this.repository);

  @override
  Future<Either<Failure, MeetingModel>> call(String params) async {
    return await repository.bookAppointment(params);
  }
}