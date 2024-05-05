import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/profile/Domain/Entite/profile_entitie.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<ProfileEntitie>>> getUsers();
}
