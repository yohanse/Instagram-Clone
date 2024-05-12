part of 'fetch_messages_bloc.dart';

sealed class FetchMessagesState extends Equatable {
  const FetchMessagesState();

  @override
  List<Object> get props => [];
}

final class FetchMessagesInitial extends FetchMessagesState {}

final class FetchMessagesLoadingState extends FetchMessagesState {
  @override
  List<Object> get props => [];
}

final class FetchMessagesLoadedState extends FetchMessagesState {
  final List<MessageEntitie> messages;
  const FetchMessagesLoadedState({required this.messages});
  @override
  List<Object> get props => [messages];
}

final class FetchMessagesErrorState extends FetchMessagesState {
  final String message;
  const FetchMessagesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
