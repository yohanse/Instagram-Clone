part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}


class LogInEven extends LoginEvent {
  final String username, password;

  const LogInEven({required this.username, required this.password});
}