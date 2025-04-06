class Expert{
  final String expertId;
  final String name;
  final String? image;
  final String description;
  final int xp;
  final double rating;
  final String experience;
  final String patientsTreated;

  const Expert({
    required this.expertId,
    required this.name,
    required this.image,
    required this.description,
    required this.xp,
    required this.rating,
    required this.experience,
    required this.patientsTreated,
  });
}