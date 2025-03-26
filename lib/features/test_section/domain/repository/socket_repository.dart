import 'package:dapple/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class SocketRepository {
  Future<Either<Failure,void>> initSocket();
  Future<Either<Failure,void>> sendImage(String image, String questionId, String sessionId);
  Future<Either<Failure,void>> sendAnswer(String answer, String questionId, String sessionId);
  Future<Either<Failure,void>> closeConnection();
  Future<Either<Failure,void>> retryAnswer(String questionId, String sessionId);
}