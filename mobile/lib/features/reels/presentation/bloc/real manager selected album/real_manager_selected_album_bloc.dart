import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

part 'real_manager_selected_album_event.dart';
part 'real_manager_selected_album_state.dart';

class RealManagerSelectedAlbumBloc
    extends Bloc<RealManagerSelectedAlbumEvent, RealManagerSelectedAlbumState> {
  RealManagerSelectedAlbumBloc() : super(RealManagerSelectedAlbumInitial()) {
    on<SelecteReelAlbum>((event, emit) {
      emit(RealManagerSelectedAlbumSuccessState(
          selectedAlbum: event.selectedAlbum));
    });
  }
}
