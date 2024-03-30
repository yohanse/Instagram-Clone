import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';

import '../repository/post_repository.dart';

class AddPostUseCase implements Usecase<PostEntite, ParamsAddPost> {
  final PostRepository postRepository;
  AddPostUseCase({required this.postRepository});

  @override
  Future<Either<Failure, PostEntite>> call(ParamsAddPost params) async {
    return await postRepository.addPost(params.postEntite);
  }
}

class ParamsAddPost extends Equatable {
  final PostEntite postEntite;

  const ParamsAddPost({required this.postEntite});
  @override
  List<Object?> get props => [];
}
