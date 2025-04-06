import 'package:dapple/core/error/exceptions.dart';
import 'package:dapple/init_dependencies.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/material.dart';

class SocketService {
  static IOWebSocketChannel? _channel;
  final EncryptedSharedPreferences sharedPreferences = serviceLocator();

  Future<void> initSocket() async {
    if (_channel != null) return;

    final token = sharedPreferences.getString('token');

    try {
      print("Starting WebSocket Connection...");
      _channel = IOWebSocketChannel.connect(
          Uri.parse("ws://192.168.73.4:8000/api/ws"),
          headers: {
            'Authorization': 'Bearer $token'
          }
      );

      // await Future.delayed(Duration(seconds: 5));

      _channel!.stream.listen(
            (message) {
          debugPrint("Received from server: $message");
        },
        onError: (error) {
          debugPrint("WebSocket Error: ${error.toString()}");
        },
        onDone: () {
          debugPrint("WebSocket Closed");
          _channel = null;
        },
      );
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  void sendImage(String image, String questionId, String sessionId) {
    try {
      if (_channel == null) throw Exception("WebSocket is not connected!");
      final data = {
        'type': 'image',
        'image': image,
        'questionId': questionId,
        'sessionId': sessionId,
      };
      _channel!.sink.add(data.toString());
      _channel!.stream.listen(
              (message) {
            debugPrint("Received from server: $message");
          });
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  void sendAnswer(String answer, String questionId, String sessionId) {
    try {
      if (_channel == null) throw Exception("WebSocket is not connected!");
      final data = {
        'type': 'answer',
        'answer': answer,
        'questionId': questionId,
        'sessionId': sessionId,
      };
      _channel!.sink.add(data.toString());
      _channel!.stream.listen(
              (message) {
            debugPrint("Received from server: $message");
          });
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  void closeConnection() {
    try {
      _channel?.sink.close(status.normalClosure);
      _channel = null;
    } catch (e) {
      debugPrint("Error closing WebSocket: $e");
    }
  }
}