import 'dart:convert';

import 'package:dapple/core/error/exceptions.dart';
import 'package:dapple/core/routes/headers.dart';
import 'package:dapple/features/home/data/models/daily_goal_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract interface class DailyGoalDataSource {
  Future<DailyGoalModel> getDailyGoal();

  Future<bool> markCompleted(String answer);
}

class DailyGoalDataSourceImpl implements DailyGoalDataSource {
  final serverUrl = dotenv.env['BACKEND_URL'];

  @override
  Future<DailyGoalModel> getDailyGoal() async {
    try {
      http.Response response =
          await http.get(headers: headers, Uri.parse('$serverUrl/daily_goal'));
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return DailyGoalModel.fromJson(json);
      } else {
        throw ServerException(json["error"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> markCompleted(String answer) async {
    try{
      http.Response response = await http.post(
        headers: headers,
        Uri.parse('$serverUrl/daily_goal/mark_completed'),
        body: {
          "answer": answer
        }
      );
      final json = jsonDecode(response.body);
      if(response.statusCode == 200){
        return json["completed"]=="true";
      } else {
        throw ServerException(json["error"]);
      }
    } catch(e){
      throw ServerException(e.toString());
    }
  }
}
