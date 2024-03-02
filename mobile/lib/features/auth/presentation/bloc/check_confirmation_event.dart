part of 'check_confirmation_bloc.dart';

sealed class CheckConfirmationEvent extends Equatable {
  const CheckConfirmationEvent();

  @override
  List<Object> get props => [];
}

class CheckConfirmationEven extends CheckConfirmationEvent {
  final String email, code;
  const CheckConfirmationEven({required this.email, required this.code});
}
