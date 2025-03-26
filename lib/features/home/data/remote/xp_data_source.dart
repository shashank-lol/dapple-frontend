import 'dart:convert';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

abstract interface class XpDataSource {
  Future<int> getUserXp();
}

class XpDataSourceImpl implements XpDataSource {
  final serverUrl = dotenv.env['BACKEND_URL']! + "/api";
  EncryptedSharedPreferences encryptedSharedPreferences;

  XpDataSourceImpl(this.encryptedSharedPreferences);

  @override
  Future<int> getUserXp() async {
    final String? token = encryptedSharedPreferences.getString("token");
    try {
      http.Response response = await http.get(Uri.parse("$serverUrl/user-xp"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'},
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return json["xp"];
      } else {
        throw ServerException(json["error"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}