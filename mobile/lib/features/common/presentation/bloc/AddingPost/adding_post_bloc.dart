import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adding_post_event.dart';
part 'adding_post_state.dart';

class AddingPostBloc extends Bloc<AddingPostEvent, AddingPostState> {
  AddingPostBloc() : super(AddingPostInitial()) {
    on<AddPostEvent>((event, emit) {
      
    });
  }
}
