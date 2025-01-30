class User {
  final String firstName;
  final String level;
  final String section;
  final String courseName;
  final List<String>? enrolledCourses;
  final int xp;

  User(
      {required this.firstName,
      required this.xp,
      required this.level,
      required this.section,
      required this.courseName,
      required this.enrolledCourses});

  @override
  String toString() {
    return 'User{firstName: $firstName, level: $level, section: $section, courseName: $courseName, enrolledCourses: $enrolledCourses, xp: $xp}';
  }
}
