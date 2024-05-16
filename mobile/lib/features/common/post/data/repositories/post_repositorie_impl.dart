import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/common/post/data/models/post_model.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

import '../../domain/repository/post_repository.dart';
import '../datasources/remote_data_source.dart';

class PostRepositorieImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositorieImpl(
      {required this.postRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<PostEntite>>> getAllPost() async {
    if (await networkInfo.isConnected) {
      try {
        final ans = await postRemoteDataSource.getAllPost();
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
  Future<Either<Failure, PostEntite>> addPost(PostEntite postEntite) async {
    if (await networkInfo.isConnected) {
      final PostModel postModel = PostModel(
          text: postEntite.text,
          images: postEntite.images,
      );
      try {
        final ans = await postRemoteDataSource.addPost(postModel);
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
  Future<Either<Failure, Like>> likePost() {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> unlikePost({required int id}) {
    // TODO: implement unlikePost
    throw UnimplementedError();
  }
}
