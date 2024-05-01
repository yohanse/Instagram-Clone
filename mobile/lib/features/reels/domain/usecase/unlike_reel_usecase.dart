import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/reels/domain/repository/reel_repository.dart';

class UnLikeReelUseCase implements Usecase<bool, ParamsUnLikeReel> {
  final ReelRepository reelRepository;
  UnLikeReelUseCase({required this.reelRepository});

  @override
  Future<Either<Failure, bool>> call(ParamsUnLikeReel params) async {
    return await reelRepository.unlikeReel(
      params.reelId,
      params.likeId,
    );
  }
}

class ParamsUnLikeReel extends Equatable {
  final String reelId;
  final String likeId;
  const ParamsUnLikeReel({
    required this.reelId,
    required this.likeId,
  });
  @override
  List<Object?> get props => [reelId];
}
