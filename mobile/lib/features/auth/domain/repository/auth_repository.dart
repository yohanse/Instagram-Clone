import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntitie>> checkEmail({String email});
  Future<Either<Failure, AuthEntitie>> checkConfirmation({String email, String confimationCode});
}
