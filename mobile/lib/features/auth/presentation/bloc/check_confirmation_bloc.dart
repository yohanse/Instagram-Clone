import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/auth/domain/usecases/check_confirmation.dart';

part 'check_confirmation_event.dart';
part 'check_confirmation_state.dart';

class CheckConfirmationBloc
    extends Bloc<CheckConfirmationEvent, CheckConfirmationState> {
  final CheckConfirmation checkConfirmation;
  CheckConfirmationBloc({
    required this.checkConfirmation,
  }) : super(CheckConfirmationInitial()) {
    on<CheckConfirmationEven>((event, emit) async {
      emit(CheckConfirmationLoading());
      var result = await checkConfirmation(
          Params1(email: event.email, confimationCode: event.code));
      result.fold((l) => emit(CheckConfirmationError(message: l.message)),
          (r) => emit(CheckConfirmationLoaded(isValid: r)));
    });
  }
}
