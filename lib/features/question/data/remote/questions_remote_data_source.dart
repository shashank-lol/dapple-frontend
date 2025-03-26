import 'dart:convert';
import 'dart:io';

import 'package:dapple/features/question/data/models/lessons_model.dart';
import 'package:dapple/features/question/data/models/objective_question_answer_model.dart';
import 'package:dapple/features/question/data/models/questions_progress_model.dart';
import 'package:dapple/features/question/data/models/subjective_question_answer_model.dart';
import 'package:dapple/features/question/data/models/voice_question_answer_model.dart';
import 'package:dapple/features/question/data/models/voice_question_model.dart';
import 'package:dapple/features/question/presentation/bloc/results.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';


import '../../../../core/error/exceptions.dart';
import '../models/objective_question_model.dart';
import '../models/subjective_question_model.dart';

abstract interface class QuestionsRemoteDataSource {
  Future<QuestionsProgressModel> getQuestions(String sectionId);

  Future<void> markLessonCompleted(String lessonId);

  Future<ObjectiveQuestionAnswerModel> answerObjectiveQuestion(
      int selectedOption, String questionId);

  Future<SubjectiveQuestionAnswerModel> answerSubjectiveQuestion(
      List<String> answer, String questionId);

  Future<String> getSubjectiveHint(String questionId);

  Future<VoiceQuestionAnswerModel> answerVoiceQuestion(
      String questionId, File answer);
}

class QuestionsRemoteDataSourceImpl implements QuestionsRemoteDataSource {
  EncryptedSharedPreferences encryptedSharedPreferences;

  QuestionsRemoteDataSourceImpl(this.encryptedSharedPreferences);

  final serverUrl = "${dotenv.env['BACKEND_URL']}/api";

  final testUrl = "https://dummyjson.com/c/e886-b6db-4561-b0ac";

  @override
  Future<QuestionsProgressModel> getQuestions(String sectionId) async {
    final token = encryptedSharedPreferences.getString("token");
    print(token);
    String requestUrl = '$serverUrl/section/$sectionId';
    // requestUrl = testUrl;
    final response = await http.get(
      Uri.parse(requestUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint(response.body);
    List<dynamic> questionList = [];
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body) as Map<String, dynamic>;
      for (var question in (res["data"] as List<dynamic>)) {
        if (question['type'] == null) {
          questionList.add(LessonsModel.fromJson(question));
        } else if (question['type'] == 'objective') {
          questionList.add(ObjectiveQuestionModel.fromJson(question));
        } else if (question['type'] == 'voice') {
          questionList.add(VoiceQuestionModel.fromJson(question));
        } else {
          questionList.add(SubjectiveQuestionModel.fromJson(question));
        }
      }
      return QuestionsProgressModel.fromJson(res, questionList);
    }
    throw ServerException(jsonDecode(response.body)["error"]);
  }

  // @override
  // Future<void> markLessonCompleted(String lessonId) async {
  //   //ONLY FOR TESTING
  //   try {
  //     final response = await http.get(
  //         Uri.parse(testUrl),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         // body: {
  //         //   'lessonId': lessonId,
  //         // }
  //     );
  //     if (response.statusCode == 200) {
  //       return;
  //     } else {
  //       throw ServerException(jsonDecode(response.body)["error"]);
  //     }
  //   } on Exception catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }

  @override
  Future<void> markLessonCompleted(String lessonId) async {
    final token = encryptedSharedPreferences.getString("token");
    try {
      final response = await http.put(
          Uri.parse('$serverUrl/section/update-section-progress'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'lessonId': lessonId,
          }));
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException(jsonDecode(response.body)["error"]);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ObjectiveQuestionAnswerModel> answerObjectiveQuestion(
      int selectedOption, String questionId) async {
    // final testUrl = "https://dummyjson.com/c/a023-f9c3-41b1-aa51";
    final token = encryptedSharedPreferences.getString("token");
    try {
      final http.Response response = await http.post(
        Uri.parse('$serverUrl/question/evaluate-answer/objective'),
        // Uri.parse(testUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'selectedOption': selectedOption,
          'questionId': questionId,
        }),
      );
      print(response.body);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (json['timeTaken'] != null) {
          Results.time = json['timeTaken'];
        }
        if(json['totalXp'] != null){
          Results.xp = json['totalXp'];
        }
        ObjectiveQuestionAnswerModel answerModel =
            ObjectiveQuestionAnswerModel.fromJson(json);
        answerModel.isCorrect =
            answerModel.correctOptionIndex == selectedOption;
        return answerModel;
      } else {
        throw ServerException(json["error"]);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SubjectiveQuestionAnswerModel> answerSubjectiveQuestion(
      List<String> answer, String questionId) async {
    final token = encryptedSharedPreferences.getString("token");
    try {
      final http.Response response = await http.post(
        Uri.parse('$serverUrl/question/evaluate-answer/subjective'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'userAnswer': answer,
          'questionId': questionId,
        }),
      );
      debugPrint(response.body);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (json['timeTaken'] != null) {
          Results.time = json['timeTaken'];
        }
        if(json['totalXp'] != null){
          Results.xp = json['totalXp'];
        }
        return SubjectiveQuestionAnswerModel.fromJson(json);
      } else {
        throw ServerException(json["error"]);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<SubjectiveQuestionAnswerModel> answerSubjectiveQuestion(
  //     List<String> answer, String questionId) async {
  //   try {
  //     final http.Response response = await http.get(
  //       Uri.parse('https://dummyjson.com/c/253b-a636-4cc7-91cd'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode({
  //         'userAnswer': answer,
  //         'questionId': questionId,
  //       }),
  //     );
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       return SubjectiveQuestionAnswerModel.fromJson(
  //           jsonDecode(response.body));
  //     } else {
  //       throw ServerException(jsonDecode(response.body)["error"]);
  //     }
  //   } on Exception catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }

  @override
  Future<String> getSubjectiveHint(String questionId) async {
    final token = encryptedSharedPreferences.getString("token");
    try {
      final http.Response response = await http.get(
        Uri.parse('$serverUrl/question/$questionId/hint'),
        // Uri.parse("https://dummyjson.com/c/de0a-4f06-4c37-a4af"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["hint"];
      } else {
        throw ServerException(jsonDecode(response.body)["error"]);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<VoiceQuestionAnswerModel> answerVoiceQuestion(
      String questionId, File answer) async {
    final token = encryptedSharedPreferences.getString("token");
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$serverUrl/question/evaluate-answer/voice'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['questionId'] = questionId;
      // Detect MIME type dynamically
      String? mimeType = lookupMimeType(answer.path) ?? 'audio/wav';
      request.files.add(await http.MultipartFile.fromPath('file', answer.path,
          contentType: MediaType.parse(mimeType)));
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      debugPrint(responseString);
      final json = jsonDecode(responseString);
      if (response.statusCode == 200) {
        if (json['timeTaken'] != null) {
          Results.time = json['timeTaken'];
        }
        if(json['totalXp'] != null){
          Results.xp = json['totalXp'];
        }
        return VoiceQuestionAnswerModel.fromJson(json);
      } else {
        throw ServerException(json["error"]);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
