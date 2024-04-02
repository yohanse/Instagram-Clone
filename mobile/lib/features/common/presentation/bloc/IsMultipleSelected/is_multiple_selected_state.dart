part of 'is_multiple_selected_bloc.dart';

sealed class IsMultipleSelectedState extends Equatable {
  const IsMultipleSelectedState();

  @override
  List<Object> get props => [];
}

final class IsMultipleSelectedInitial extends IsMultipleSelectedState {
  const IsMultipleSelectedInitial();
}


class Selected extends IsMultipleSelectedState {}

class NotSelected extends IsMultipleSelectedState {}
