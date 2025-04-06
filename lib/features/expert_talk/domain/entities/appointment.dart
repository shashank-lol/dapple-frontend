class Appointment{
  final String expertName;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final double expertRating;
  final String? imageUrl;
  final String expertDescription;


  const Appointment({
    required this.expertName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.expertRating,
    required this.imageUrl,
    required this.expertDescription,
  });
}