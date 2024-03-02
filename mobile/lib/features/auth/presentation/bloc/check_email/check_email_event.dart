part of 'check_email_bloc.dart';

sealed class CheckEmailEvent extends Equatable {
  const CheckEmailEvent();

  @override
  List<Object> get props => [];
}

class CheckEmailEven extends CheckEmailEvent {
  final String email;
  const CheckEmailEven({required this.email});
}

