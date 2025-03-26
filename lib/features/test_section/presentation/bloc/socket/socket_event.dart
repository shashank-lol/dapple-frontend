part of 'socket_bloc.dart';

@immutable
sealed class SocketEvent {}

class InitSocketEvent extends SocketEvent {}

class SendImageEvent extends SocketEvent {
  final File image;
  final String questionId;
  final String sessionId;

  SendImageEvent(this.image, this.questionId, this.sessionId);
}

class SendAnswerEvent extends SocketEvent {
  final String answer;
  final String questionId;
  final String sessionId;

  SendAnswerEvent(this.answer, this.questionId, this.sessionId);
}

class AnswerRetryEvent extends SocketEvent {
  final String questionId;
  final String sessionId;

  AnswerRetryEvent(this.questionId, this.sessionId);
}

class CloseSocketEvent extends SocketEvent {}