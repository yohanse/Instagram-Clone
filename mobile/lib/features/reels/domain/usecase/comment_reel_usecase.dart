import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/repository/reel_repository.dart';



class CommentReelUseCase implements Usecase<Comment, ParamsCommentReel> {
  final ReelRepository reelRepository;
  CommentReelUseCase({required this.reelRepository});

  @override
  Future<Either<Failure, Comment>> call(ParamsCommentReel params) async {
    return await reelRepository.commentReel(params.reelId, params.content);
  }
}

class ParamsCommentReel extends Equatable {
  final String reelId;
  final String content;
  const ParamsCommentReel({required this.reelId, required this.content});
  @override
  List<Object?> get props => [];
}