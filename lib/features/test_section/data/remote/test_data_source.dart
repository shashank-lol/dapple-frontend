import 'dart:convert';

import 'package:dapple/features/test_section/data/model/test_result_model.dart';
import 'package:dapple/features/test_section/data/model/test_section_data_model.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/error/exceptions.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

abstract interface class TestDataSource {
  Future<TestSectionDataModel> getTestQuestions(String sectionId);

  Future<TestResultModel> getTestResult(String sessionId, String sectionId);
}

class TestDataSourceImpl implements TestDataSource {
  EncryptedSharedPreferences sharedPreferences;

  TestDataSourceImpl(this.sharedPreferences);

  final serverUrl = "${dotenv.env['BACKEND_URL']}/api";

  @override
  Future<TestSectionDataModel> getTestQuestions(String sectionId) async {
    final token = sharedPreferences.getString('token');
    print("Request Recvd");
    try {
      final response = await http.get(
        Uri.parse('$serverUrl/section/$sectionId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint(response.statusCode.toString());
      final json = jsonDecode(response.body);
      debugPrint(json.toString());
      if (response.statusCode == 200) {
        return TestSectionDataModel.fromJson(json);
      } else {
        throw ServerException(json['error']);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TestResultModel> getTestResult(
      String sessionId, String sectionId) async {
    try {
      debugPrint(sessionId);
      debugPrint(sectionId);
      final response = await http.get(
        Uri.parse('$serverUrl/test/result').replace(queryParameters: {
          'sessionId': sessionId,
          'sectionId': sectionId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return TestResultModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(jsonDecode(response.body)['error']);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
