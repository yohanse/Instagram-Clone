import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/repository/reel_repository.dart';



class LikeReelUseCase implements Usecase<Like, ParamsLikeReel> {
  final ReelRepository reelRepository;
  LikeReelUseCase({required this.reelRepository});

  @override
  Future<Either<Failure, Like>> call(ParamsLikeReel params) async {
    return await reelRepository.likeReel(params.reelId);
  }
}

class ParamsLikeReel extends Equatable {
  final String reelId;
  const ParamsLikeReel({required this.reelId});
  @override
  List<Object?> get props => [reelId];
}