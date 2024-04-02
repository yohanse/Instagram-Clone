part of 'is_multiple_selected_bloc.dart';

sealed class IsMultipleSelectedEvent extends Equatable {
  const IsMultipleSelectedEvent();

  @override
  List<Object> get props => [];
}

class ChangeIsSelected extends IsMultipleSelectedEvent {
  final bool isSelected;

  const ChangeIsSelected({required this.isSelected});
}
