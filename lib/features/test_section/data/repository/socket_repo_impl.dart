import 'package:dapple/core/error/exceptions.dart';
import 'package:dapple/features/test_section/data/remote/normal_data_source.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repository/socket_repository.dart';

class SocketRepositoryImpl implements SocketRepository {
  final NormalDataSource dataSource;

  SocketRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure,void>> initSocket() async {
    try {
      await dataSource.initSocket();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure,void>> sendImage(String image, String questionId, String sessionId) async {
    try {
      await dataSource.sendImage(image, questionId, sessionId);
      return Future.value(right(null));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure,void>> sendAnswer(String answer, String questionId, String sessionId) async {
    try {
      await dataSource.sendAnswer(answer, questionId, sessionId);
      return Future.value(right(null));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  // @override
  // Future<Either<Failure,void>> closeConnection() async {
  //   try {
  //     await dataSource.closeConnection();
  //     return Future.value(right(null));
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }

  @override
  Future<Either<Failure, void>> retryAnswer(String questionId, String sessionId) async {
    try{
      await dataSource.retryAnswer(questionId, sessionId);
      return Future.value(right(null));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}