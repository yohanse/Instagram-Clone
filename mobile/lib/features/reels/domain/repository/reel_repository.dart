import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

abstract class ReelRepository {
  Future<Either<Failure, List<ReelEntite>>> getAllReels();
}
