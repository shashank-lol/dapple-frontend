import 'package:dapple/core/entities/user.dart';
class UserModel extends User{
  UserModel({
    required super.firstName,
    required super.level,
    required super.section,
    required super.xp
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      level: json['level'],
      section: json['section'],
      xp: json['xp'],
    );
  }
  // empty usermodel
  factory UserModel.empty() {
    return UserModel(
      firstName: '',
      level: 0,
      section: 0,
      xp: 0,
    );
  }

}
