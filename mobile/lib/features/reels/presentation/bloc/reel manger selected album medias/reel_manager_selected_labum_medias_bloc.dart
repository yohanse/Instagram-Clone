import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

part 'reel_manager_selected_labum_medias_event.dart';
part 'reel_manager_selected_labum_medias_state.dart';

class ReelManagerSelectedLabumMediasBloc extends Bloc<ReelManagerSelectedLabumMediasEvent, ReelManagerSelectedLabumMediasState> {
  ReelManagerSelectedLabumMediasBloc() : super(ReelManagerSelectedLabumMediasInitial()) {
    on<ReelManagerSelectedLabumMediasEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
