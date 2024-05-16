import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';

import '../repository/post_repository.dart';

class UnLikePostUseCase implements Usecase<bool, ParamsUnLikePost> {
  final PostRepository postRepository;
  UnLikePostUseCase({required this.postRepository});

  @override
  Future<Either<Failure, bool>> call(ParamsUnLikePost params) async {
    return await postRepository.unlikePost();
  }
}

class ParamsUnLikePost extends Equatable {
  final int id;
  const ParamsUnLikePost({required this.id});
  @override
  List<Object?> get props => [];
}
