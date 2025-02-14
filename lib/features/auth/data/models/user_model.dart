import 'package:dapple/core/entities/user.dart';
class UserModel extends User{
  UserModel({
    required super.firstName,
    required super.xp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      xp: json['xp'],
      //cast to list of string
    );
  }

  @override
  String toString() {
    return 'UserModel{}';
  }

  // empty usermodel
  factory UserModel.empty() {
    return UserModel(
      firstName: '',
      xp: 0,
    );
  }

}
