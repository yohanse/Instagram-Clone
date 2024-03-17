import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';
import 'package:mobile/features/auth/domain/usecases/signup.dart';

part 'singup_event.dart';
part 'singup_state.dart';

class SingupBloc extends Bloc<SingupEvent, SingupState> {
  final SignUpUsecase signUpUsecase;
  SingupBloc(this.signUpUsecase) : super(SingupInitial()) {
    on<SignUpEven>((event, emit) async {
      emit(SignUpLoading());
      var result = await signUpUsecase(
        AuthEntitie(
          email: event.email,
          password: event.password,
          fullName: event.fullName,
          userName: event.userName,
          birthDate: event.birthDate,
        ),
      );
      result.fold((l) => emit(SignUpError(message: l.message)),
          (r) => emit(SignUpLoaded(isValid: r)));
    });
  }
}
