part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}


class LogInLoading extends LoginState {}

class LogInLoaded extends LoginState {
  final bool isValid;
  const LogInLoaded({required this.isValid});
}

class LogInError extends LoginState {
  final String message;
  const LogInError({required this.message});
}