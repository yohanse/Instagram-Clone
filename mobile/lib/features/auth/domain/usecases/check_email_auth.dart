import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class CheckEmailUsecase implements Usecase<bool, Params> {
  final AuthRepository authRepository;
  CheckEmailUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return authRepository.checkEmail(
        email: params.email);
  }
}

class Params extends Equatable {
  final String email;

  const Params({required this.email}):super();
  
  @override
  List<Object?> get props => [email];
}