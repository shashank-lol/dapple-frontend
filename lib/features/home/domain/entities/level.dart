class Level {
  final String name;
  final String description;
  final String? imageUrl;
  final List<String>? sections;

  Level(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.sections});
}
