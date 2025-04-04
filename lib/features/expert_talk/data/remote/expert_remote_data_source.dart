import 'dart:convert';

import 'package:dapple/features/expert_talk/data/models/expert_model.dart';
import 'package:dapple/init_dependencies.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';

abstract class ExpertRemoteDataSource {
  Future<List<ExpertModel>> getExperts();
}

class ExpertRemoteDataSourceImpl implements ExpertRemoteDataSource {
  final String serverUrl = "${dotenv.env["BACKEND_URL"]!}/api";
  EncryptedSharedPreferences encryptedSharedPreferences = serviceLocator();

  @override
  Future<List<ExpertModel>> getExperts() async {
    final String? token = encryptedSharedPreferences.getString("token");
    if (token == null) {
      throw ServerException("Token not found");
    }

    try {
      final response = await http.get(
        Uri.parse("$serverUrl/experts"), // Adjust endpoint as needed
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint(json.toString());

        // Assuming the response wraps experts in a "data" field or similar
        if (json != null && json is List) {
          return (json).map((item) => ExpertModel.fromJson(item)).toList();
        } else {
          throw ServerException("Invalid response format");
        }
      } else {
        throw ServerException(json["error"] ?? "Failed to load experts");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
