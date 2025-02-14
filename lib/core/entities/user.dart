class User {
  final String firstName;
  final int xp;

  User(
      {required this.firstName,
      required this.xp,});

  @override
  String toString() {
    return 'User{firstName: $firstName, xp: $xp}';
  }
}
