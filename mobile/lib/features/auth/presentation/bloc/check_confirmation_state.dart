part of 'check_confirmation_bloc.dart';

sealed class CheckConfirmationState extends Equatable {
  const CheckConfirmationState();
  
  @override
  List<Object> get props => [];
}

final class CheckConfirmationInitial extends CheckConfirmationState {}
