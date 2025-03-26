import 'package:dapple/features/test_section/domain/usecases/get_test_questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/test_question.dart';

part 'test_questions_state.dart';

class TestQuestionsCubit extends Cubit<TestQuestionsState> {
  GetTestQuestion _getTestQuestion;

  TestQuestionsCubit({required GetTestQuestion getTestQuestion})
      : _getTestQuestion = getTestQuestion,
        super(TestQuestionsInitial());

  Future<void> loadQuestions(String sectionId) async {
    emit(TestQuestionsLoading());
    await _getTestQuestion(sectionId).then((value) {
      value.fold((failure) {
        emit(TestQuestionsError(failure.message));
      }, (data) {
        emit(TestQuestionsLoaded(data.questions, data.sessionId,0));
      });
    });
  }

  int getNextQuestionIndex() {
    if (state is TestQuestionsLoaded) {
      final loadedState = state as TestQuestionsLoaded;
      final index = loadedState.currentIndex;
      emit(TestQuestionsLoaded(loadedState.questions, loadedState.sessionId, loadedState.currentIndex + 1));
      return index;
    }
    return 0;
  }
}
 