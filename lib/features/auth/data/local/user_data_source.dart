import 'package:dapple/features/auth/data/models/user_model.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';

abstract interface class UserDataSource {
  Future<void> saveUserDetails(
      String token, String firstName, int xp, String levelNo, String sectionNo, String courseName);

  UserModel? getCurrentUser();
}

class UserDataSourceImpl implements UserDataSource {
  EncryptedSharedPreferences sharedPref;
  UserDataSourceImpl(this.sharedPref);

  @override
  Future<void> saveUserDetails(String token, String firstName, int xp,
      String levelNo, String sectionNo, String courseName) async {
    await sharedPref.setString("token", token);
    await sharedPref.setString("userFirstName", firstName);
    await sharedPref.setInt("userXp", xp);
    await sharedPref.setString("userLevel", levelNo);
    await sharedPref.setString("userSection", sectionNo);
    await sharedPref.setString("courseName", courseName);
  }

  @override
  UserModel? getCurrentUser() {
    try {
      String? firstName = sharedPref.getString("userFirstName");
      int? xp = sharedPref.getInt("userXp");
      String? levelNo = sharedPref.getString("userLevel");
      String? sectionNo = sharedPref.getString("userSection");
      String? courseName = sharedPref.getString("courseName");
      if (firstName != null &&
          xp != null &&
          levelNo != null &&
          sectionNo != null && courseName != null) {
        return UserModel(
            firstName: firstName, xp: xp, level: levelNo, section: sectionNo, courseName: courseName);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
