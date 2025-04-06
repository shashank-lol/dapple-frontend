import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repository/appointments_repository.dart';
import '../local/dummy_appointments.dart';
import '../models/meeting_model.dart';
import '../remote/appointment_remote_data_source.dart';
import 'package:flutter/material.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;
  final AppointmentLocalDataSource appointmentLocalDataSource =
      AppointmentLocalDataSourceImpl();

  AppointmentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Appointment>>> getAppointments() async {
    try {
      // TODO: Uncomment the remote data source call when available
      // final appointments = appointmentLocalDataSource.getAppointments();
      // return Right(
      //     await Future.delayed(Duration.zero, () => appointments));
      final appointments = await remoteDataSource.getAllAppointments();
      return Right(appointments);
    } catch (e) {
      // Show local appointments if remote call fails
      debugPrint("Error fetching remote appointments: $e");
      final localAppointments = appointmentLocalDataSource.getAppointments();
      return Right(
          await Future.delayed(Duration.zero, () => localAppointments));
      return Left(Failure(e is ServerException ? e.message : e.toString()));
    }
  }

  @override
  Future<Either<Failure,MeetingModel>> bookAppointment(String timeSlotId) async {
    try {
      final meeting = await remoteDataSource.bookAppointment(timeSlotId);
      return Right(meeting); // Success case
    } on ServerException catch (e) {
      return Left(Failure('Failed to book appointment: ${e.message}'));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}