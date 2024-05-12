import 'package:equatable/equatable.dart';
import 'package:mobile/features/profile/Data/model/profile_model.dart';

class MessageEntitie extends Equatable {
  final ProfileModel sender;
  final ProfileModel receiver;
  final String content;
  final String? link;
  final DateTime createdAt;
  const MessageEntitie({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.link,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [sender, receiver, content, link, createdAt,];
}


