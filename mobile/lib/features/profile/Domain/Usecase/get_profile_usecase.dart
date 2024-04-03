import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/profile/Domain/Entite/ProfileEntitie.dart';
import 'package:mobile/features/profile/Domain/Repository/profile_repository.dart';

class GetProfileUsecase implements Usecase<ProfileEntitie, ParamsGetProfile> {
  final ProfileRepository profileRepository;
  GetProfileUsecase({required this.profileRepository});

  @override
  Future<Either<Failure, ProfileEntitie>> call(
      ParamsGetProfile params) async {
    return await profileRepository.getProfile();
  }
}

class ParamsGetProfile extends Equatable {
  @override
  List<Object?> get props => [];
}
