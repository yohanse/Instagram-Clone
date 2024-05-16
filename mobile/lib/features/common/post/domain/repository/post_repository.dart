import 'package:mobile/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntite>>> getAllPost();
  Future<Either<Failure, PostEntite>> addPost(PostEntite postEntite);
  Future<Either<Failure, Like>> likePost({required int postId});
  Future<Either<Failure, bool>> unlikePost({required int postId, required int likeId});
  Future<Either<Failure, Comment>> commentPost({required int postId, required String content});

  // Future<Either<Failure, bool>> getPost({required String email, required String confimationCode});
  // Future<Either<Failure, bool>> deletePost({required String email, required String confimationCode});
  // Future<Either<Failure, bool>> updatePost({required String email, required String confimationCode});

  // Future<Either<Failure, bool>> commentAtPost({required String email, required String confimationCode});
}
