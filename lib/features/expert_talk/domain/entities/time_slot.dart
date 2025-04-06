class TimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  final String timeSlotId;
  final bool isAvailable;

  const TimeSlot({
    required this.startTime,
    required this.endTime,
    required this.timeSlotId,
    required this.isAvailable,
  });

  TimeSlot.empty()
      : startTime = DateTime.now(),
        endTime = DateTime.now(),
        timeSlotId = '',
        isAvailable = false;

  @override
  String toString() {
    return "TimeSlot(start: $startTime, end: $endTime, id: $timeSlotId, available: $isAvailable)";
  }
}
