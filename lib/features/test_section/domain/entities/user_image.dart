import 'dart:io';

class UserImage{
  final File image;
  final String questionId;
  final String sessionId;

  UserImage({required this.image, required this.questionId, required this.sessionId});
}