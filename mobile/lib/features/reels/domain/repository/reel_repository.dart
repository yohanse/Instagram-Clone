import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

abstract class ReelRepository {
  Future<Either<Failure, List<ReelEntite>>> getAllReels();
  Future<Either<Failure, ReelEntite>> getReel(String reelId);
  Future<Either<Failure, bool>> likeReel(String reelId);
  Future<Either<Failure, Comment>> commentReel(String reelId, String content);
  Future<Either<Failure, bool>> unlikeReel(String reelId);
}
