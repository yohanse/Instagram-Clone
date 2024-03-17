part of 'singup_bloc.dart';

sealed class SingupState extends Equatable {
  const SingupState();
  
  @override
  List<Object> get props => [];
}

final class SingupInitial extends SingupState {}



class SignUpLoading extends SingupState {}

class SignUpLoaded extends SingupState {
  final bool isValid;
  const SignUpLoaded({required this.isValid});
}

class SignUpError extends SingupState {
  final String message;
  const SignUpError({required this.message});
}
