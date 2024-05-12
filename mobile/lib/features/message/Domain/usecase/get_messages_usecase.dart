import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecase/usecase.dart';
import 'package:mobile/features/message/Domain/entitie/message_entitie.dart';
import 'package:mobile/features/message/Domain/repository/message_repository.dart';

class GetMessagesUsecase
    implements Usecase<List<MessageEntitie>, ParamsGetMessages> {
  final MessageRepository messageRepository;
  GetMessagesUsecase({required this.messageRepository});
  @override
  Future<Either<Failure, List<MessageEntitie>>> call(
      ParamsGetMessages params) async {
    return await messageRepository.getMessages(params.receiverId);
  }
}

class ParamsGetMessages extends Equatable {
  final String receiverId;
  const ParamsGetMessages({required this.receiverId});
  @override
  List<Object?> get props => [receiverId];
}
