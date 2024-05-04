import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/repository/reel_repository.dart';



class AddReelUseCase implements Usecase<ReelEntite, ParamsAddReel> {
  final ReelRepository reelRepository;
  AddReelUseCase({required this.reelRepository});

  @override
  Future<Either<Failure, ReelEntite>> call(ParamsAddReel params) async {
    return await reelRepository.likeReel(params.reelId);
  }
}

class ParamsAddReel extends Equatable {
  final String filePath;
  final String content;
  const ParamsAddReel({required this.filePath, required this.content,});
  @override
  List<Object?> get props => [filePath, content];
}