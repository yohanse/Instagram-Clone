import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'check_confirmation_event.dart';
part 'check_confirmation_state.dart';

class CheckConfirmationBloc extends Bloc<CheckConfirmationEvent, CheckConfirmationState> {
  CheckConfirmationBloc() : super(CheckConfirmationInitial()) {
    on<CheckConfirmationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
