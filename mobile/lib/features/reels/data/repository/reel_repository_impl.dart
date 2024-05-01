import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/reels/data/data%20source/remote_data_source.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/repository/reel_repository.dart';

import '../../../../core/error/exception.dart';

class ReelRepositoryImpl implements ReelRepository {
  final ReelRemoteDataSource reelRemoteDataSource;
  final NetworkInfo networkInfo;

  const ReelRepositoryImpl({required this.reelRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<ReelEntite>>> getAllReels() async {
    if (await networkInfo.isConnected) {
      
      try {
        final ans = await reelRemoteDataSource.getAllReel();
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
  Future<Either<Failure, bool>> likeReel(String reelId) async {
    if (await networkInfo.isConnected) {
      
      try {
        final ans = await reelRemoteDataSource.likeReel(reelId);
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
  Future<Either<Failure, ReelEntite>> getReel(String reelId) async{
    if (await networkInfo.isConnected) {
      
      try {
        final ans = await reelRemoteDataSource.getReel(reelId);
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
  Future<Either<Failure, Comment>> commentReel(String reelId, String content) async {
     if (await networkInfo.isConnected) {
      
      try {
        final ans = await reelRemoteDataSource.commentReel(reelId, content);
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
  Future<Either<Failure, bool>> unlikeReel(String reelId, String likeId) async {
    if (await networkInfo.isConnected) {
      
      try {
        final ans = await reelRemoteDataSource.unlikeReel(reelId, likeId);
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
  
}