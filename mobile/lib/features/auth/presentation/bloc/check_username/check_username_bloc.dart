import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/auth/domain/usecases/check_username.dart';

part 'check_username_event.dart';
part 'check_username_state.dart';

class CheckUsernameBloc extends Bloc<CheckUsernameEvent, CheckUsernameState> {
  final CheckUsernameUsecase checkUsernameUsecase;
  CheckUsernameBloc({required this.checkUsernameUsecase}) : super(CheckUsernameInitial()) {
    on<CheckUsernameEven>((event, emit) async {
     emit(CheckUsernameLoading());
      var result = await checkUsernameUsecase(Params3(username: event.username));
      result.fold((l) => emit(CheckUsernameError(message: l.message)),
          (r) => emit(CheckUsernameLoaded(isValid: r)));

    });
  }
}
