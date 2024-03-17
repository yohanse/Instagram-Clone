import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/auth/data/datasources/local_data_source.dart';
import 'package:mobile/features/auth/data/datasources/remote_data_source.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class AuthRepositorieImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositorieImpl(
      {required this.authLocalDataSource,
      required this.authRemoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, bool>> checkConfirmation(
      {required String email, required String confimationCode}) async {
    if (await networkInfo.isConnected) {
      try {
        final ans = await authRemoteDataSource.checkConfirmation(
            email: email, confimationCode: confimationCode);
        return Right(ans);
      } on ServerException {
        return const Left(ServerFailure("Server not working properly."));
      } on EmailNotCorrectException {
        return const Left(EmailNotCorrectFailure("Email not correct"));
      }
    } else {
      return const Left(NetworkFailure("Netwrok error."));
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmail({required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        final ans = await authRemoteDataSource.checkEmail(email: email);
        return Right(ans);
      } on ServerException {
        return const Left(ServerFailure("Server not working properly."));
      } on EmailAlreadyExistException {
        return const Left(
            EmailAlreadyExistFaliure("Email already have an account."));
      } on EmailDoesNotExistException {
        return const Left(EmailDoesNotExistFaliure("Wrong email."));
      }
    } else {
      return const Left(NetworkFailure("Network error."));
    }
  }

  @override
  Future<Either<Failure, bool>> checkUsername(
      {required String username}) async {
    print("repository");
    if (await networkInfo.isConnected) {
      print("have network");
      try {
        final ans =
            await authRemoteDataSource.checkUsername(username: username);
        return Right(ans);
      } on ServerException {
        return const Left(ServerFailure("Server not working properly."));
      } on EmailAlreadyExistException {
        return const Left(
            EmailAlreadyExistFaliure("Email already have an account."));
      } on EmailDoesNotExistException {
        return const Left(EmailDoesNotExistFaliure("Wrong email."));
      }
    } else {
      return const Left(NetworkFailure("Network error."));
    }
  }
}
