import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/auth/data/datasources/remote_data_source.dart';
import 'package:mobile/features/auth/data/models/auth_model.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';

class AuthRepositorieImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositorieImpl(
      {required this.authRemoteDataSource, required this.networkInfo});

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
      } on WrongEmailFormatException {
        return const Left(WrongEmailFormatFailure("Email format is wrong."));
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

  @override
  Future<Either<Failure, bool>> singUp({required AuthEntitie user}) async {
    if (await networkInfo.isConnected) {
      AuthModel authModel = new AuthModel(
        email: user.email,
        password: user.password,
        fullName: user.fullName,
        userName: user.userName,
        birthDate: user.birthDate,
      );
      try {
        final ans = await authRemoteDataSource.signUp(user: authModel);
        return Right(ans);
      } on ServerException {
        return const Left(ServerFailure("Server not working properly."));
      }
    } else {
      return const Left(NetworkFailure("Network error."));
    }
  }

  @override
  Future<Either<Failure, bool>> logIn(
      {required String username, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final ans = await authRemoteDataSource.logIn(
            username: username, password: password);
        return Right(ans);
      } on ServerException {
        return const Left(ServerFailure("Server not working properly."));
      } on UsernameAndPasswordDoesNotMatchException {
        return const Left(UsernameAndPasswordDoesNotMatchFailure(
            "Username and password does not match."));
      }
    } else {
      return const Left(NetworkFailure("Network error."));
    }
  }
}



// @override
//   Future<Either<Failure, bool>> signup(
//       {required AuthEntitie authEntitie}) async {
//     try {
//       AuthEntitieModel authEntitieModel = AuthEntitieModel(
//         email: authEntitie.email,
//         password: authEntitie.password,
//         fullName: authEntitie.fullName,
//         bio: authEntitie.bio,
//         expertise: authEntitie.expertise,
//       );
//       await authRemoteDataSource.signup(authEntitieModel: authEntitieModel);
//       return const Right(true);
//     } on EmailAndPasswordNotMatchException {
//       return const Left(EmailAndPasswordNotMatchFailure(
//         message: "your email and password does not match",
//         statusCode: 400,
//       ));
//     } on ServerException catch (e) {
//       return Left(
//         ServerFailure(
//           message: "the server does not work know",
//           statusCode: e.statusCode,
//         ),
//       );
//     } on NetworkConnectionException {
//       return const Left(NetworkConnectionFailure(
//         message: "there is no connection",
//         statusCode: 400,
//       ));
//     }
//   }
