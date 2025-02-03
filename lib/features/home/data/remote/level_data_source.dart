import 'dart:convert';

import 'package:dapple/core/routes/headers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/level.dart';
import 'package:http/http.dart' as http;

import '../models/level_model.dart';

abstract interface class LevelDataSource {
  Future<List<Level>> getAllLevels();
}

class LevelDataSourceImpl implements LevelDataSource {
  final serverUrl = dotenv.env['BACKEND_URL'];
  @override
  Future<List<Level>> getAllLevels() async {
    try {
      http.Response response = await http.get(headers: headers,
          Uri.parse('$serverUrl/levels'));
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return (json as List).map((e) => LevelModel.fromJson(e)).toList();
      } else {
        throw ServerException(json["error"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}