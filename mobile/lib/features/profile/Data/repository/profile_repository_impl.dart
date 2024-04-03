import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/profile/Data/data_source/remote_data_source.dart';
import 'package:mobile/features/profile/Domain/Entite/profile_entitie.dart';
import 'package:mobile/features/profile/Domain/Repository/profile_repository.dart';

class ProfileREpositoryImplementation implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileREpositoryImplementation({required this.remoteDataSource});
  @override
  Future<Either<Failure, ProfileEntitie>> getProfile() async {
    try {
      final profile = await remoteDataSource.getProfile();
      return Right(profile);
    } catch (err) {
      return const Left(ServerFailure("Server Failure"));
    }
  }
}
