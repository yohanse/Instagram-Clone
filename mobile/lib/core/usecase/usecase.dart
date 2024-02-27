import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
