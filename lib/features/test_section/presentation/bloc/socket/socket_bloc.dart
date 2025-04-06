import 'dart:convert';
import 'dart:io';

import 'package:dapple/features/test_section/domain/usecases/retry_answer.dart';
import 'package:flutter/material.dart';

import 'package:dapple/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/init_socket.dart';
import '../../../domain/usecases/send_answer.dart';
import '../../../domain/usecases/send_image.dart';

part 'socket_event.dart';

part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  final InitSocket _initSocket;
  final SendImage _sendImage;
  final SendAnswer _sendAnswer;
  // final CloseSocket _closeSocket;
  final RetryAnswer _retryAnswer;

  SocketBloc(
      {required InitSocket initSocket,
      required SendImage sendImage,
      required SendAnswer sendAnswer,
      // required CloseSocket closeSocket,
      required RetryAnswer retryAnswer})
      : _initSocket = initSocket,
        _sendImage = sendImage,
        _sendAnswer = sendAnswer,
        // _closeSocket = closeSocket,
        _retryAnswer = retryAnswer,
        super(SocketInitial()) {
    on<InitSocketEvent>((event, emit) async {
      final result = await _initSocket(NoParams());
      result.fold(
        (failure) => emit(SocketError(failure.message)),
        (_) => emit(SocketConnected()),
      );
    });

    on<SendImageEvent>((event, emit) async {
      // convert image file to base 64
      emit(SocketLoading());
      List<int> imageBytes = await event.image.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      print("base64Image: $base64Image");
      final res = await _sendImage(
          SendImageParams(base64Image, event.questionId, event.sessionId));
      res.fold(
        (failure) => emit(SocketError(failure.message)),
        (_) => emit(SocketMessageReceived()),
      );
    });

    on<SendAnswerEvent>((event, emit) async {
      emit(SocketLoading());
      final res = await _sendAnswer(
          SendAnswerParams(event.answer, event.questionId, event.sessionId));
      res.fold(
        (failure) => emit(SocketError(failure.message)),
        (_) => emit(SocketMessageReceived(questionIndex: event.questionIndex)),
      );
    });

    // void generateResult(){
    //   context
    //       .read<ResultCubit>()
    //       .calculateResult(widget.sessionId, widget.sectionId);
    // }

    // on<CloseSocketEvent>((event, emit) async {
    //   final res = await _closeSocket(NoParams());
    //   res.fold(
    //     (failure) => emit(SocketError(failure.message)),
    //     (_) => emit(SocketClosed()),
    //   );
    // });
    on<AnswerRetryEvent>((event, emit) async {
      // emit(SocketLoading());
      final res = await _retryAnswer(
          RetryAnswerParams(event.questionId, event.sessionId));
      res.fold(
        (failure) => emit(SocketError(failure.message)),
        (_) => emit(SocketMessageReceived()),
      );
    });
  }
}
