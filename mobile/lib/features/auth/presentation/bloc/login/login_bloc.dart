import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/auth/domain/usecases/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LogInUsecase logInUsecase;
  LoginBloc({required this.logInUsecase}) : super(LoginInitial()) {
    on<LogInEven>((event, emit) async {
      emit(LogInLoading());
      var result = await logInUsecase(
        Params4(
          username: event.username,
          password: event.password,
        ),
      );
      result.fold((l) => emit(LogInError(message: l.message)),
          (r) => emit(LogInLoaded(isValid: r)));
    });
  }
}
