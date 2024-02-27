import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class CheckConfirmation implements Usecase<AuthEntitie, Params> {
  final AuthRepository authRepository;
  CheckConfirmation({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntitie>> call(Params params) async {
    return authRepository.checkConfirmation(
        email: params.email, confimationCode: params.confimationCode);
  }
}

class Params extends Equatable {
  final String email, confimationCode;

  const Params({required this.email, required this.confimationCode}):super();
  
  @override
  List<Object?> get props => [email, confimationCode];
}