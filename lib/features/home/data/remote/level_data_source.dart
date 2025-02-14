import 'dart:convert';

import 'package:dapple/features/home/data/models/level_section_wrapper.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;

abstract interface class LevelDataSource {
  Future<LevelSectionWrapper> getAllLevels();
}

class LevelDataSourceImpl implements LevelDataSource {
  final serverUrl = dotenv.env['BACKEND_URL']! + "/api";
  final testUrl = "https://dummyjson.com/c/5153-86a3-4081-aef";
  EncryptedSharedPreferences encryptedSharedPreferences;

  LevelDataSourceImpl(this.encryptedSharedPreferences);

  @override
  Future<LevelSectionWrapper> getAllLevels() async {
    final String? token = encryptedSharedPreferences.getString("token");
    if(token == null) {
      throw ServerException("Token not found");
    }
    try {
      http.Response response = await http.get(headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, Uri.parse("$serverUrl/user-course"));
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint(json.toString());
        return LevelSectionWrapper.fromJson(json);
      } else {
        throw ServerException(json["error"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
