import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_users_event.dart';
part 'list_users_state.dart';

class ListUsersBloc extends Bloc<ListUsersEvent, ListUsersState> {
  ListUsersBloc() : super(ListUsersInitial()) {
    on<ListUsersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
