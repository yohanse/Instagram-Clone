import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/auth/domain/usecases/check_confirmation.dart';
import 'package:mobile/features/auth/domain/usecases/check_email_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckEmail checkEmail;
  final CheckConfirmation checkConfirmation;
  AuthBloc({required this.checkConfirmation, required this.checkEmail})
      : super(AuthInitial()) {
    on<AuthCheckEmail>((event, emit) async {
      emit(AuthLoading());
      var result = await checkEmail(Params(email: event.email));
      result.fold((l) => emit(AuthError(message: l.message)),
          (r) => emit(AuthLoaded(isValid: r)));
    });
    on<AuthCheckConfirmation>((event, emit) async {
      emit(AuthLoading());
      var result = await checkConfirmation(Params1(email: event.email, confimationCode: event.code));
      result.fold((l) => emit(AuthError(message: l.message)),
          (r) => emit(AuthLoaded(isValid: r)));
    });
  }
}
