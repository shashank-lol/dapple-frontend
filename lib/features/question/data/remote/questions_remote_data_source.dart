import 'dart:convert';

import 'package:dapple/features/question/data/models/lessons_model.dart';
import 'package:dapple/features/question/data/models/objective_question_answer_model.dart';
import 'package:dapple/features/question/data/models/questions_progress_model.dart';
import 'package:dapple/features/question/data/models/subjective_question_answer_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
}

class QuestionsRemoteDataSourceImpl implements QuestionsRemoteDataSource {
  QuestionsRemoteDataSourceImpl();

  final serverUrl = "${dotenv.env['BACKEND_URL']}/api";
  final token = dotenv.env['TOKEN'];
  final testUrl = "https://dummyjson.com/c/e886-b6db-4561-b0ac";

  @override
  Future<QuestionsProgressModel> getQuestions(String sectionId) async {
    String requestUrl = '$serverUrl/section/$sectionId';
    requestUrl = testUrl;
    final response = await http.get(
      Uri.parse(requestUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
    );
    debugPrint(response.body);
    List<dynamic> questionList = [];
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body) as Map<String,dynamic>;
      for (var question in (res["data"] as List<dynamic>)) {
        if (question['type'] == null) {
          questionList.add(LessonsModel.fromJson(question));
        } else if (question['type'] == 'objective') {
          questionList.add(ObjectiveQuestionModel.fromJson(question));
        } else {
          questionList.add(SubjectiveQuestionModel.fromJson(question));
        }
      }
      return QuestionsProgressModel.fromJson(res, questionList);
    }
    throw ServerException(jsonDecode(response.body)["error"]);
  }

  @override
  Future<void> markLessonCompleted(String lessonId) async {
    //ONLY FOR TESTING
    try {
      final response = await http.get(
          Uri.parse(testUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          // body: {
          //   'lessonId': lessonId,
          // }
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException(jsonDecode(response.body)["error"]);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<void> markLessonCompleted(String lessonId) async {
  //   try {
  //     final response = await http.put(
  //         Uri.parse('$serverUrl/section/update-section-progress'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         body: {
  //           'lessonId': lessonId,
  //         });
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
  Future<ObjectiveQuestionAnswerModel> answerObjectiveQuestion(
      int selectedOption, String questionId) async {
    final testUrl = "https://dummyjson.com/c/a023-f9c3-41b1-aa51";
    try {
      final http.Response response = await http.get(
        // Uri.parse('$serverUrl/question/evaluate-answer/objective'),
        Uri.parse(testUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode({
        //   'selectedOption': selectedOption,
        //   'questionId': questionId,
        // }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        ObjectiveQuestionAnswerModel answerModel =
            ObjectiveQuestionAnswerModel.fromJson(jsonDecode(response.body));
        answerModel.isCorrect =
            answerModel.correctOptionIndex == selectedOption;
        return answerModel;
      } else {
        throw ServerException(jsonDecode(response.body)["error"]);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<SubjectiveQuestionAnswerModel> answerSubjectiveQuestion(
  //     List<String> answer, String questionId) async {
  //   try {
  //     final http.Response response = await http.post(
  //       Uri.parse('$serverUrl/question/evaluate-answer/subjective'),
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
  //
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
  Future<SubjectiveQuestionAnswerModel> answerSubjectiveQuestion(
      List<String> answer, String questionId) async {
    try {
      final http.Response response = await http.get(
        Uri.parse('https://dummyjson.com/c/253b-a636-4cc7-91cd'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode({
        //   'userAnswer': answer,
        //   'questionId': questionId,
        // }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return SubjectiveQuestionAnswerModel.fromJson(
            jsonDecode(response.body));
      } else {
        throw ServerException(jsonDecode(response.body)["error"]);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> getSubjectiveHint(String questionId) async {
    try{
      final http.Response response = await http.get(
        // Uri.parse('$serverUrl/question/$questionId/hint'),
        Uri.parse("https://dummyjson.com/c/de0a-4f06-4c37-a4af"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint(response.body);
      if(response.statusCode == 200){
        return jsonDecode(response.body)["hint"];
      } else {
        throw ServerException(jsonDecode(response.body)["error"]);
      }
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
