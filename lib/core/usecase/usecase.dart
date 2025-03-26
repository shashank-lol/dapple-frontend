import 'package:dapple/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<T, P> {
  Future<Either<Failure,T>> call(P params);
}

class NoParams{
  NoParams();
}