import 'package:dapple/features/expert_talk/data/models/time_slot_model.dart';
import 'package:dapple/features/expert_talk/domain/entities/booking.dart';

class BookingModel extends Booking {
  const BookingModel({
    required super.date,
    required super.timeSlots,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      date: DateTime.parse(json['date']).toLocal(), // Assuming ISO 8601 format
      timeSlots: (json['timeSlots'] as List)
          .map((item) => TimeSlotModel.fromJson(item))
          .toList(),
    );
  }
}
