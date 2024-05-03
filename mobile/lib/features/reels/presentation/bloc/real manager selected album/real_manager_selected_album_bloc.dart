import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/reel%20manger%20selected%20album%20medias/reel_manager_selected_labum_medias_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

part 'real_manager_selected_album_event.dart';
part 'real_manager_selected_album_state.dart';

class RealManagerSelectedAlbumBloc
    extends Bloc<RealManagerSelectedAlbumEvent, RealManagerSelectedAlbumState> {
  RealManagerSelectedAlbumBloc() : super(RealManagerSelectedAlbumInitial()) {
    on<SelecteReelAlbum>((event, emit) {
      emit(RealManagerSelectedAlbumSuccessState(
          selectedAlbum: event.selectedAlbum));
      BlocProvider.of<ReelManagerSelectedLabumMediasBloc>(event.context).add(FetchSlectedAlbumMediasEvent(currentAlbum: event.selectedAlbum));
    });
    
  }
}
