import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/message/Domain/usecase/get_users_usecase.dart';

import '../../../../profile/Domain/Entite/profile_entitie.dart';

part 'list_users_event.dart';
part 'list_users_state.dart';

class ListUsersBloc extends Bloc<ListUsersEvent, ListUsersState> {
  final GetUserUsecase getUserUsecase;
  ListUsersBloc({
    required this.getUserUsecase,
  }) : super(ListUsersInitial()) {
    on<GetUsersEvent>((event, emit) async {
      emit(ListUsersLoadingState());
      var result = await getUserUsecase(ParamsGetUser());
      result.fold(
        (failure) => emit(ListUsersErrorState(message: failure.message)),
        (users) => emit(ListUsersLoadedState(users: users)),
      );
    });
  }
}
