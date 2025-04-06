import 'package:dapple/features/expert_talk/domain/entities/time_slot.dart';

class Booking{
  final DateTime date;
  final List<TimeSlot> timeSlots;

  const Booking({
    required this.date,
    required this.timeSlots,
  });
}