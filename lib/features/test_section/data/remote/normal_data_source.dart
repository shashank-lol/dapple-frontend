import 'dart:convert';
import 'package:dapple/core/error/exceptions.dart';
import 'package:dapple/init_dependencies.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class NormalDataSource {
  Future<void> initSocket();

  Future<void> sendImage(String image, String questionId, String sessionId);

  Future<void> sendAnswer(String answer, String questionId, String sessionId);

  Future<void> retryAnswer(String questionId, String sessionId);

// No stream in HTTP, so we'll remove this for now. If you need real-time updates, you might use WebSockets or long polling.
// Stream<String> get messages;
}

class NormalDataSourceImpl implements NormalDataSource {
  final EncryptedSharedPreferences sharedPreferences = serviceLocator();
  final String baseUrl = "${dotenv.env['BACKEND_URL']}/api";

  NormalDataSourceImpl();

  @override
  Future<void> initSocket() async {
    final token = sharedPreferences.getString('token');
    if (token == null || token.isEmpty) {
      throw ServerException("No authentication token available");
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/init'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to initialize: ${response.body}');
      }

      final decoded = jsonDecode(response.body);
      if (decoded['status'] != 'success') {
        throw ServerException(decoded['message'] ?? 'Initialization failed');
      }

      debugPrint("Successfully initialized HTTP connection");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = sharedPreferences.getString('token');
    if (token == null || token.isEmpty) {
      throw ServerException("No authentication token available");
    }
    debugPrint("Token: $token");
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<void> sendImage(
      String image, String questionId, String sessionId) async {
    final headers = await _getHeaders();
    final data = {
      'imageUrl': image,
      'questionId': questionId,
      'sessionId': sessionId,
    };

    try {
      debugPrint("Sending image to Harshal");
      final response = await http.post(
        Uri.parse('$baseUrl/test/upload-image'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to send image: ${response.body}');
      }

      final decoded = jsonDecode(response.body);
      debugPrint("Decoded response: $decoded");
      if (decoded['status'] != 'success') {
        throw ServerException(decoded['message'] ?? 'Send image failed');
      }

      debugPrint("Image sent successfully");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> sendAnswer(
      String answer, String questionId, String sessionId) async {
    final headers = await _getHeaders();
    debugPrint("$questionId");
    debugPrint("$sessionId");
    final data = {
      'answer': answer,
      'questionId': questionId,
      'sessionId': sessionId,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/test/upload-text'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to send answer: ${response.body}');
      }

      final decoded = jsonDecode(response.body);
      debugPrint("====================\nDecoded response: $decoded");
      if (decoded['status'] != 'success') {
        throw ServerException(decoded['message'] ?? 'Send answer failed');
      }

      debugPrint("Answer sent successfully");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> retryAnswer(String questionId, String sessionId) async {
    final headers = await _getHeaders();
    final data = {
      'questionId': questionId,
      'sessionId': sessionId,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/test/retry'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to retry answer: ${response.body}');
      }

      final decoded = jsonDecode(response.body);
      if (decoded['status'] != 'success') {
        throw ServerException(decoded['message'] ?? 'Retry failed');
      }

      debugPrint("Retry successful");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}