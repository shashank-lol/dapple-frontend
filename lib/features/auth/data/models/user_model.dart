import 'package:dapple/core/entities/user.dart';
class UserModel extends User{
  UserModel({
    required super.firstName,
    required super.level,
    required super.section,
    required super.xp,
    required super.courseName,
    required super.enrolledCourses
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      level: json['lastCompletedSection']['level'],
      section: json['lastCompletedSection']['section'],
      xp: json['xp'],
      courseName: json['lastCompletedSection']['courseName'],
      //cast to list of string
      enrolledCourses: json['courses'].map<String>((course) => course.toString()).toList(),
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
      level: "0",
      section: "0",
      courseName: '0',
      xp: 0,
      enrolledCourses: []
    );
  }

}
