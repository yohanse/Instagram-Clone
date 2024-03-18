import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class LogInUsecase implements Usecase<bool, Params4> {
  final AuthRepository authRepository;
  LogInUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(Params4 user) async {
    return authRepository.logIn(username: user.username, password: user.password);
  }
}

class Params4 {
  final String username, password;

  Params4({required this.username, required this.password});
  
}
