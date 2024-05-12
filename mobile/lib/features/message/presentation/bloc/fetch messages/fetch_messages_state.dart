part of 'fetch_messages_bloc.dart';

sealed class FetchMessagesState extends Equatable {
  const FetchMessagesState();

  @override
  List<Object> get props => [];
}

final class FetchMessagesInitial extends FetchMessagesState {}

final class FetchMessagesLoadingState extends FetchMessagesState {}

final class FetchMessagesLoadedState extends FetchMessagesState {
  final List<MessageEntitie> messages;
  const FetchMessagesLoadedState({required this.messages});
}

final class FetchMessagesErrorState extends FetchMessagesState {
  final String message;
  const FetchMessagesErrorState({required this.message});
}
