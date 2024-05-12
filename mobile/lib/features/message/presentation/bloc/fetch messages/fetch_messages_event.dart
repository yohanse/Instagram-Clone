part of 'fetch_messages_bloc.dart';

sealed class FetchMessagesEvent extends Equatable {
  const FetchMessagesEvent();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends FetchMessagesEvent {
  final String recieverId;
  const GetMessagesEvent({required this.recieverId});
}

class SendMessageEvent extends FetchMessagesEvent {
  final dynamic message;
  const SendMessageEvent({
    required this.message,
  });
}