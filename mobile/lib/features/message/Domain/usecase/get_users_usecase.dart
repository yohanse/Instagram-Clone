import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/message/Domain/repository/message_repository.dart';
import 'package:mobile/features/profile/Domain/Entite/profile_entitie.dart';

class GetUserUsecase implements Usecase<List<ProfileEntitie>, ParamsGetUser> {
  final MessageRepository messageRepository;
  GetUserUsecase({required this.messageRepository});
  @override
  Future<Either<Failure, List<ProfileEntitie>>> call(ParamsGetUser params) async {
    return await messageRepository.getUsers();
  }
}

class ParamsGetUser extends Equatable {
  @override
  List<Object?> get props => [];
}