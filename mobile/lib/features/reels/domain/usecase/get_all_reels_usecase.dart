import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/repository/reel_repository.dart';



class GetAllReelUseCase implements Usecase<List<ReelEntite>, ParamsGetAllReel> {
  final ReelRepository reelRepository;
  GetAllReelUseCase({required this.reelRepository});

  @override
  Future<Either<Failure, List<ReelEntite>>> call(ParamsGetAllReel params) async {
    return await reelRepository.getAllReels();
  }
}

class ParamsGetAllReel extends Equatable {
  @override
  List<Object?> get props => [];
}