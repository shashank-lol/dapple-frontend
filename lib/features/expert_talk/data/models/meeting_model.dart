import 'package:dapple/features/expert_talk/domain/entities/meeting.dart';

class MeetingModel extends Meeting {
  const MeetingModel({
    required super.calendarLink,
    required super.appointmentId,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    return MeetingModel(
      calendarLink: json['googleCalendarLink'] as String? ?? '', // Default to empty string if null
      appointmentId: json['appointmentId'] as String? ?? '', // Default to empty string if null
    );
  }

}