import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'is_multiple_selected_event.dart';
part 'is_multiple_selected_state.dart';

class IsMultipleSelectedBloc
    extends Bloc<IsMultipleSelectedEvent, IsMultipleSelectedState> {
  IsMultipleSelectedBloc() : super(NotSelected()) {
    on<ChangeIsSelected>((event, emit) {
      if (!event.isSelected) {
        emit(Selected());
      } else {
        emit(NotSelected());
      }
    });
  }
}
