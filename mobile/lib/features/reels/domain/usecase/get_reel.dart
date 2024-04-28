import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/repository/reel_repository.dart';



class GetReelUseCase implements Usecase<ReelEntite, ParamsGetReel> {
  final ReelRepository reelRepository;
  GetReelUseCase({required this.reelRepository});

  @override
  Future<Either<Failure, ReelEntite>> call(ParamsGetReel params) async {
    return await reelRepository.getReel(params.reelId);
  }
}

class ParamsGetReel extends Equatable {
  final String reelId;
  const ParamsGetReel({required this.reelId});
  @override
  List<Object?> get props => [];
}