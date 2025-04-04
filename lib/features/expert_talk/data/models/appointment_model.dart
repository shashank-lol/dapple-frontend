import 'package:dapple/features/expert_talk/domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  const AppointmentModel(
      {required super.expertName,
      required super.date,
      required super.startTime,
      required super.endTime,
      required super.expertRating,
        required super.imageUrl,
        required super.expertDescription
      });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      expertName: json['name'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      expertRating: json['rating'],
      imageUrl: json['imageUrl'],
      expertDescription: json['description'],
    );
  }

}
