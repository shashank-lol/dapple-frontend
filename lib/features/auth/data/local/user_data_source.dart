import 'package:dapple/features/auth/data/models/user_model.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';

abstract interface class UserDataSource {
  Future<void> saveUserDetails(
      String token, String firstName, int xp, int levelNo, int sectionNo);

  UserModel? getCurrentUser();
}

class UserDataSourceImpl implements UserDataSource {
  EncryptedSharedPreferences sharedPref;
  UserDataSourceImpl(this.sharedPref);

  @override
  Future<void> saveUserDetails(String token, String firstName, int xp,
      int levelNo, int sectionNo) async {
    await sharedPref.setString("token", token);
    await sharedPref.setString("userFirstName", firstName);
    await sharedPref.setInt("userXp", xp);
    await sharedPref.setInt("userLevel", levelNo);
    await sharedPref.setInt("userSection", sectionNo);
  }

  @override
  UserModel? getCurrentUser() {
    try {
      String? firstName = sharedPref.getString("userFirstName");
      int? xp = sharedPref.getInt("userXp");
      int? levelNo = sharedPref.getInt("userLevel");
      int? sectionNo = sharedPref.getInt("userSection");
      if (firstName != null &&
          xp != null &&
          levelNo != null &&
          sectionNo != null) {
        return UserModel(
            firstName: firstName, xp: xp, level: levelNo, section: sectionNo);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
