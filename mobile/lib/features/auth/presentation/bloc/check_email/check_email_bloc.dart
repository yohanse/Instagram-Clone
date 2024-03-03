import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/auth/domain/usecases/check_email_auth.dart';

part 'check_email_event.dart';
part 'check_email_state.dart';

class CheckEmailBloc extends Bloc<CheckEmailEvent, AuthState> {
  final CheckEmailUsecase checkEmail;
  CheckEmailBloc({ required this.checkEmail})
      : super(AuthInitial()) {
    on<CheckEmailEven>((event, emit) async {
      emit(CheckEmailLoading());
      var result = await checkEmail(Params(email: event.email));
      result.fold((l) => emit(CheckEmailError(message: l.message)),
          (r) => emit(CheckEmailLoaded(isValid: r)));
    });
  }
}
