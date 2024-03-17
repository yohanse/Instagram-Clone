import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class SignUpUsecase implements Usecase<bool, AuthEntitie> {
  final AuthRepository authRepository;
  SignUpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(AuthEntitie user) async {
    return authRepository.singUp(
        user: user);
  }
}

class Params3 extends Equatable {
  final String username;

  const Params3({required this.username}):super();
  
  @override
  List<Object?> get props => [username];
}