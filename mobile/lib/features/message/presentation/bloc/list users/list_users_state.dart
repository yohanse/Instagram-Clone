part of 'list_users_bloc.dart';

sealed class ListUsersState extends Equatable {
  const ListUsersState();
  
  @override
  List<Object> get props => [];
}

final class ListUsersInitial extends ListUsersState {}
