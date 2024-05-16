import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

import '../repository/post_repository.dart';

class LikePostUseCase implements Usecase<Like, ParamsLikePost> {
  final PostRepository postRepository;
  LikePostUseCase({required this.postRepository});

  @override
  Future<Either<Failure, Like>> call(ParamsLikePost params) async {
    return await postRepository.likePost(postId:params.postId);
  }
}

class ParamsLikePost extends Equatable {
  final int postId;
  const ParamsLikePost({required this.postId});
  @override
  List<Object?> get props => [];
}
