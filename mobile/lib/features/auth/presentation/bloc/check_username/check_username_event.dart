part of 'check_username_bloc.dart';

sealed class CheckUsernameEvent extends Equatable {
  const CheckUsernameEvent();

  @override
  List<Object> get props => [];
}

class CheckUsernameEven extends CheckUsernameEvent {
  final String username;
  const CheckUsernameEven({required this.username});
}
