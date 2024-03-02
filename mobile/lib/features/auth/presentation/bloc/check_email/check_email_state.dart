part of 'check_email_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthInitialState extends AuthState {}

class CheckEmailLoading extends AuthState {}

class CheckEmailLoaded extends AuthState {
  final bool isValid;
  const CheckEmailLoaded({required this.isValid});
}

class CheckEmailError extends AuthState {
  final String message;
  const CheckEmailError({required this.message});
}