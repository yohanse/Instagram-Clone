import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';

import '../repository/post_repository.dart';

class GetAllPostUseCase implements Usecase<List<PostEntite>, ParamsGetAllPost> {
  final PostRepository postRepository;
  GetAllPostUseCase({required this.postRepository});

  @override
  Future<Either<Failure, List<PostEntite>>> call(ParamsGetAllPost params) async {
    return await postRepository.getAllPost();
  }
}

class ParamsGetAllPost extends Equatable {
  
  @override
  List<Object?> get props => [];
}