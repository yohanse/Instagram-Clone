import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/message/Domain/entitie/message_entitie.dart';
import 'package:mobile/features/message/Domain/repository/message_repository.dart';
import 'package:mobile/features/message/data/data_source/remote_data_source.dart';
import 'package:mobile/features/profile/Domain/Entite/profile_entitie.dart';

class MessageRepositoryImpl extends MessageRepository {
  final MessageRemoteDataSource messageRemoteDataSource;
  MessageRepositoryImpl({required this.messageRemoteDataSource,});
  @override
  Future<Either<Failure, List<ProfileEntitie>>> getUsers() async {
    try {
      final users = await messageRemoteDataSource.getUsers();
      return Right(users);
    } catch (err) {
      return const Left(ServerFailure("Server Failure"));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntitie>>> getMessages(receiverId) async {
    try {
      final users = await messageRemoteDataSource.getMessages(receiverId);
      return Right(users);
    } catch (err) {
      return const Left(ServerFailure("Server Failure"));
    }
  }
  
}