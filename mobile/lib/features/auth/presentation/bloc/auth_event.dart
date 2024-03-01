part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEmail extends AuthEvent {
  final String email;
  const AuthCheckEmail({required this.email});
}

class AuthCheckConfirmation extends AuthEvent {
  final String email, code;
  const AuthCheckConfirmation({required this.email, required this.code});
}
