part of 'check_confirmation_bloc.dart';

sealed class CheckConfirmationState extends Equatable {
  const CheckConfirmationState();
  
  @override
  List<Object> get props => [];
}

final class CheckConfirmationInitial extends CheckConfirmationState {}

class CheckConfirmationLoading extends CheckConfirmationState {}

class CheckConfirmationLoaded extends CheckConfirmationState {
  final bool isValid;
  const CheckConfirmationLoaded({required this.isValid});
}

class CheckConfirmationError extends CheckConfirmationState {
  final String message;
  const CheckConfirmationError({required this.message});
}
