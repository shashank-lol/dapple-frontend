import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repository/appointments_repository.dart';
import '../local/dummy_appointments.dart';
import '../remote/appointment_remote_data_source.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;
  final AppointmentLocalDataSource appointmentLocalDataSource =
      AppointmentLocalDataSourceImpl();

  AppointmentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Appointment>>> getAppointments() async {
    try {
      // TODO: Uncomment the remote data source call when available
      final appointments = appointmentLocalDataSource.getAppointments();
      return Right(
          await Future.delayed(Duration.zero, () => appointments));
      // final appointments = await remoteDataSource.getAllAppointments();
      // return Right(appointments);
    } catch (e) {
      // Show local appointments if remote call fails
      final localAppointments = appointmentLocalDataSource.getAppointments();
      return Right(
          await Future.delayed(Duration.zero, () => localAppointments));
      return Left(Failure(e is ServerException ? e.message : e.toString()));
    }
  }
}