import 'package:dapple/features/expert_talk/data/models/appointment_model.dart';

abstract class AppointmentLocalDataSource {
  Future<List<AppointmentModel>> getAppointments();
}

class AppointmentLocalDataSourceImpl implements AppointmentLocalDataSource {
  @override
  Future<List<AppointmentModel>> getAppointments() async {
    // Hardcoded list of appointments
    final appointments = [
      AppointmentModel(
        expertName: 'Dr. Alice Johnson',
        date: "4 April", // Tomorrow
        startTime: "10:00 AM",
        endTime: "11:00 AM",
        expertRating: 4.9,
        imageUrl: 'https://example.com/alice.jpg',
        expertDescription: "Experienced Neurologist with 10 years of practice",
      ),
      AppointmentModel(
        expertName: 'Dr. Bob Wilson',
        date: "4 April", // Tomorrow
        startTime: "10:00 AM",
        endTime: "11:00 AM",
        expertRating: 4.7,
        imageUrl: 'https://example.com/bob.jpg',
        expertDescription: "Orthopedic Surgeon specializing in joint replacements",
      ),
      AppointmentModel(
        expertName: 'Dr. Charlie Brown',
        date: "4 April", // Tomorrow
        startTime: "10:00 AM",
        endTime: "11:00 AM",
        expertRating: 4.5,
        imageUrl: null, // No image for this appointment
        expertDescription: "Pediatrician with a focus on child development",
      ),
    ];

    return appointments;
  }
}