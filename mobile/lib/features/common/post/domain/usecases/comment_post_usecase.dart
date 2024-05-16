import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

import '../repository/post_repository.dart';

class CommentPostUseCase implements Usecase<Comment, ParamsCommentPost> {
  final PostRepository postRepository;
  CommentPostUseCase({required this.postRepository});

  @override
  Future<Either<Failure, Comment>> call(ParamsCommentPost params) async {
    return await postRepository.commentPost(postId: params.postId, content: params.content);
  }
}

class ParamsCommentPost extends Equatable {
  final String content;
  final int postId;
  const ParamsCommentPost({required this.content, required this.postId});
  @override
  List<Object?> get props => [];
}
