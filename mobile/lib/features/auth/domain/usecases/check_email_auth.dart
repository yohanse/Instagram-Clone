import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class CheckEmail {
  final AuthRepository authRepository;
  CheckEmail({required this.authRepository});
  Future<Either<Failure, AuthEntitie>> execute({required String email}) async {
    return authRepository.checkEmail(email: email);
  }
}
