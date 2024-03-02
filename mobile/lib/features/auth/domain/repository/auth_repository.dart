import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> checkEmail({required String email});
  Future<Either<Failure, bool>> checkConfirmation({required String email, required String confimationCode});
}
