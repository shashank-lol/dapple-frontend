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
      expertName: json['expertName'],
      date: DateTime.parse(json['date']).toLocal(),
      startTime: DateTime.parse(json['startTime']).toLocal(),
      endTime: DateTime.parse(json['endTime']).toLocal(),
      expertRating: json['rating'],
      imageUrl: json['imageUrl'],
      expertDescription: json['bio'],
    );
  }

}
