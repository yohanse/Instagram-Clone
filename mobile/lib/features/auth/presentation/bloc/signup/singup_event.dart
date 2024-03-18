part of 'singup_bloc.dart';

sealed class SingupEvent extends Equatable {
  const SingupEvent();

  @override
  List<Object> get props => [];
}

class SignUpEven extends SingupEvent {
  final String email, password;
  final String fullName, userName;
  final DateTime birthDate;

  const SignUpEven({required this.email, required this.password, required this.fullName, required this.userName, required this.birthDate});
}