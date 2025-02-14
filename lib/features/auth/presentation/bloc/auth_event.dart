part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String gender;
  final String profession;
  final List<String> socialChallenges;
  final List<String> socialSettings;
  final int age;

  AuthSignUp({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
    required this.profession,
    required this.socialChallenges,
    required this.socialSettings,
    required this.age
  });
}

final class AuthLogInWithEmail extends AuthEvent {
  final String email;
  final String password;

  AuthLogInWithEmail({
    required this.email,
    required this.password,
  });
}

final class AuthLogInWithGoogle extends AuthEvent {

  AuthLogInWithGoogle();
}

final class AuthSignUpWithGoogle extends AuthEvent {
  final String gender;
  final String profession;
  final List<String> socialChallenges;
  final List<String> socialSettings;
  final int age;

  AuthSignUpWithGoogle({
    required this.gender,
    required this.profession,
    required this.socialChallenges,
    required this.socialSettings,
    required this.age
  });
}



final class AuthCurrentUser extends AuthEvent{}
