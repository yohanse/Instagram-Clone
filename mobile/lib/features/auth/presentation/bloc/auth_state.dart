part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final bool isValid;
  const AuthLoaded({required this.isValid});
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
}