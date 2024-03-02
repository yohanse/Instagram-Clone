import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/auth/domain/usecases/check_email_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckEmail checkEmail;
  AuthBloc({ required this.checkEmail})
      : super(AuthInitial()) {
    on<AuthCheckEmail>((event, emit) async {
      emit(AuthLoading());
      var result = await checkEmail(Params(email: event.email));
      result.fold((l) => emit(AuthError(message: l.message)),
          (r) => emit(AuthLoaded(isValid: r)));
    });
  }
}
