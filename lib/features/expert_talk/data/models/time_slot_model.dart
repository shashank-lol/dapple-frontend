import '../../domain/entities/time_slot.dart';

class TimeSlotModel extends TimeSlot {
  const TimeSlotModel({
    required super.startTime,
    required super.endTime,
    required super.timeSlotId,
    required super.isAvailable,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      startTime: DateTime.parse(json['startTime']).toLocal().subtract(Duration(days: 1)), // Assuming ISO 8601 format
      endTime: DateTime.parse(json['endTime']).toLocal().subtract(Duration(days: 1)), // Assuming ISO 8601 format
      timeSlotId: json['timeSlotId'],
      isAvailable: json['available'] as bool,
    );
  }
}
