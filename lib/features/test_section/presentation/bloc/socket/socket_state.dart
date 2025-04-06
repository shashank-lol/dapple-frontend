part of 'socket_bloc.dart';

@immutable
sealed class SocketState {}

final class SocketInitial extends SocketState {}

class SocketConnected extends SocketState {}

class SocketMessageReceived extends SocketState {
  final int? questionIndex;

  SocketMessageReceived({this.questionIndex});
}

class SocketError extends SocketState {
  final String error;

  SocketError(this.error);
}

class SocketLoading extends SocketState {}

class SocketClosed extends SocketState {}
