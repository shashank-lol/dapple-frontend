import 'package:encrypt_shared_preferences/provider.dart';

abstract interface class UserLocalData{
  Future<void> updateUserXpToLocal(int xp);
}

class UserLocalDataImpl implements UserLocalData {
  EncryptedSharedPreferences sharedPreferences;

  UserLocalDataImpl(this.sharedPreferences);
  @override
  Future<void> updateUserXpToLocal(int xp) async {
    await sharedPreferences.setInt("userXp", xp);
  }
}