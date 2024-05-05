part of 'list_users_bloc.dart';

sealed class ListUsersState extends Equatable {
  const ListUsersState();

  @override
  List<Object> get props => [];
}

final class ListUsersInitial extends ListUsersState {}

final class ListUsersLoadedState extends ListUsersState {
  final List<ProfileEntitie> users;
  const ListUsersLoadedState({
    required this.users,
  });
}

final class ListUsersLoadingState extends ListUsersState {}

final class ListUsersErrorState extends ListUsersState {
  final String message;
  const ListUsersErrorState({
    required this.message,
  });
}
