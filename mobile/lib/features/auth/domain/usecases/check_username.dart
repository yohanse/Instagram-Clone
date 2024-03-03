import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class CheckUsernameUsecase implements Usecase<bool, Params3> {
  final AuthRepository authRepository;
  CheckUsernameUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(Params3 params) async {
    return authRepository.checkUsername(
        username: params.username);
  }
}

class Params3 extends Equatable {
  final String username;

  const Params3({required this.username}):super();
  
  @override
  List<Object?> get props => [username];
}