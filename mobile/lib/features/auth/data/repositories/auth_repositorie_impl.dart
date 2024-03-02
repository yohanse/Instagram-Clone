import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/auth/data/datasources/local_data_source.dart';
import 'package:mobile/features/auth/data/datasources/remote_data_source.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
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
        return const Left(ServerFailure("yohanse"));
      }
    } else {
      return const Left(NetworkFailure("yohanse"));
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmail(
      {required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        final ans = await authRemoteDataSource.checkEmail(email: email);
        return Right(ans);
      } on ServerException {
        return const Left(ServerFailure("yohanse"));
      }
    } else {
      return const Left(NetworkFailure("yohanse"));
    }
  }
}