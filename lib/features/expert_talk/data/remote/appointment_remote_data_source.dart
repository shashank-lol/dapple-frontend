import 'dart:convert';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../init_dependencies.dart';
import '../models/appointment_model.dart';

abstract class AppointmentRemoteDataSource {
  Future<List<AppointmentModel>> getAllAppointments();
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final String serverUrl = "${dotenv.env["BACKEND_URL"]!}/api";
  final EncryptedSharedPreferences encryptedSharedPreferences = serviceLocator();

  @override
  Future<List<AppointmentModel>> getAllAppointments() async {
    final String? token = encryptedSharedPreferences.getString("token");
    if (token == null) {
      throw ServerException("Token not found");
    }

    try {
      final response = await http.get(
        Uri.parse("$serverUrl/appointments"), // Adjust endpoint as needed
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint(json.toString());

        // Assuming the response wraps appointments in a "data" field or similar
        if (json != null && json is List) {
          return (json).map((item) => AppointmentModel.fromJson(item)).toList();
        } else {
          throw ServerException("Invalid response format");
        }
      } else {
        throw ServerException(json["error"] ?? "Failed to load appointments");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}