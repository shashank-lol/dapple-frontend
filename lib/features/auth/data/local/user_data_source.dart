import 'package:dapple/features/auth/data/models/user_model.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';

abstract interface class UserDataSource {
  Future<void> saveUserDetails(
      String token, String firstName, int xp, String emailId);

  UserModel? getCurrentUser();
}

class UserDataSourceImpl implements UserDataSource {
  EncryptedSharedPreferences sharedPref;

  UserDataSourceImpl(this.sharedPref);

  @override
  Future<void> saveUserDetails(
      String token, String firstName, int xp, String emailId) async {
    await sharedPref.setString("token", token);
    await sharedPref.setString("userFirstName", firstName);
    await sharedPref.setInt("userXp", xp);
    await sharedPref.setString("userEmail", emailId);
  }

  @override
  UserModel? getCurrentUser() {
    try {
      String? firstName = sharedPref.getString("userFirstName");
      int? xp = sharedPref.getInt("userXp");
      if (firstName != null && xp != null) {
        return UserModel(firstName: firstName, xp: xp);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
