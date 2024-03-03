part of 'check_username_bloc.dart';

sealed class CheckUsernameState extends Equatable {
  const CheckUsernameState();
  
  @override
  List<Object> get props => [];
}

final class CheckUsernameInitial extends CheckUsernameState {}

class CheckUsernameLoading extends CheckUsernameState {}

class CheckUsernameLoaded extends CheckUsernameState {
  final bool isValid;
  const CheckUsernameLoaded({required this.isValid});
}

class CheckUsernameError extends CheckUsernameState {
  final String message;
  const CheckUsernameError({required this.message});
}