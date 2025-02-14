import 'package:dapple/features/question/domain/entities/objective_question_answer.dart';
import 'package:dapple/features/question/domain/usecases/answer_subjective_question.dart';
import 'package:dapple/features/question/domain/usecases/mark_lesson_completed.dart';
import 'package:dapple/features/question/domain/usecases/subjective_hint.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/subjective_question_answer.dart';
import '../../../domain/usecases/answer_objective_question.dart';

part 'question_complete_event.dart';

part 'question_complete_state.dart';

class QuestionCompleteBloc
    extends Bloc<QuestionCompleteEvent, QuestionCompleteState> {
  final MarkLessonCompleted _markLessonCompleted;
  final AnswerObjectiveQuestion _answerObjectiveQuestion;
  final AnswerSubjectiveQuestion _answerSubjectiveQuestion;
  final SubjectiveHint _subjectiveHint;

  QuestionCompleteBloc(
      {required MarkLessonCompleted markLessonCompleted,
      required AnswerObjectiveQuestion answerObjectiveQuestion,
      required AnswerSubjectiveQuestion answerSubjectiveQuestion,
      required SubjectiveHint subjectiveHint})
      : _markLessonCompleted = markLessonCompleted,
        _answerObjectiveQuestion = answerObjectiveQuestion,
        _answerSubjectiveQuestion = answerSubjectiveQuestion,
        _subjectiveHint = subjectiveHint,
        super(QuestionCompleteInitial()) {
    on<LessonCompletedEvent>((event, emit) async {
      emit(CompletionLoading());
      await _markLessonCompleted(event.lessonId).then((result) {
        result.fold(
          (failure) => emit(QuestionCompleteError(failure.message)),
          (_) => emit(LessonCompleted()),
        );
      });
    });

    on<ObjectiveAnsweredEvent>((event, emit) async {
      emit(CompletionLoading());
      await _answerObjectiveQuestion(AnswerObjectiveQuestionParams(
        optionIndex: event.objectiveIndex,
        questionId: event.questionId,
      )).then((result) {
        result.fold(
          (failure) => emit(QuestionCompleteError(failure.message)),
          (res) => emit(ObjectiveAnswered(
              res.correctOptionIndex == event.objectiveIndex, res, res.xp)),
        );
      });
    });

    on<SubjectiveAnsweredEvent>((event, emit) async {
      emit(CompletionLoading());
      await _answerSubjectiveQuestion(AnswerSubjectiveQuestionParams(
        answer: event.answer,
        questionId: event.questionId,
      )).then((result) {
        result.fold(
          (failure) => emit(QuestionCompleteError(failure.message)),
          (res) => emit(SubjectiveAnswered(res, event.maxXp)),
        );
      });
    });

    on<SubjectiveAnswerHintEvent>((event, emit) async {
      emit(CompletionLoading());
      await _subjectiveHint(event.questionId).then((result) {
        result.fold(
          (failure) => emit(QuestionCompleteError(failure.message)),
          (res) => emit(SubjectiveAnswerHint(res)),
        );
      });
    });

    on<QuestionResetEvent>((event, emit) {
      emit(QuestionCompleteInitial());
    });
  }
}
