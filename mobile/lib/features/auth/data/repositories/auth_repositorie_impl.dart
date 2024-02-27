import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class AuthRepositorieImpl implements AuthRepository {
  @override
  Future<Either<Failure, AuthEntitie>> checkConfirmation({String email, String confimationCode}) {
    // TODO: implement checkConfirmation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntitie>> checkEmail({String email}) {
    // TODO: implement checkEmail
    throw UnimplementedError();
  }

}