import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class CheckConfirmation {
  final AuthRepository authRepository;
  CheckConfirmation({required this.authRepository});
  Future<Either<Failure, AuthEntitie>> execute({required String email, required String confimationCode}) async {
    return authRepository.checkConfirmation(email: email, confimationCode: confimationCode);
  }
}
