import 'package:mobile/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntite>>> getAllPost();
  // Future<Either<Failure, bool>> getPost({required String email, required String confimationCode});
  // Future<Either<Failure, bool>> deletePost({required String email, required String confimationCode});
  // Future<Either<Failure, bool>> updatePost({required String email, required String confimationCode});
  // Future<Either<Failure, bool>> likePost({required String username});
  // Future<Either<Failure, bool>> commentAtPost({required String email, required String confimationCode});
}
