import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

part 'reel_manager_selected_labum_medias_event.dart';
part 'reel_manager_selected_labum_medias_state.dart';

class ReelManagerSelectedLabumMediasBloc extends Bloc<
    ReelManagerSelectedLabumMediasEvent, ReelManagerSelectedLabumMediasState> {
  ReelManagerSelectedLabumMediasBloc()
      : super(ReelManagerSelectedLabumMediasInitial()) {
    Future<List<AssetEntity>> fetchMedias({
      required AssetPathEntity album, // The album from which to fetch media
      required int page, // The page number of media to fetch
    }) async {
      List<AssetEntity> medias = []; // List to hold fetched media items

      try {
        // Get a list of asset entities from the specified album and page
        final List<AssetEntity> entities =
            await album.getAssetListRange(start: 0, end: 80);

        final List<AssetEntity> videos = entities.where((entity) => entity.type == AssetType.video).toList();
        
        return videos;
      } catch (e) {
        // Handle any exceptions that occur during fetching
        debugPrint('Error fetching media: $e');
        throw Exception();
      }
    }

    on<FetchSlectedAlbumMediasEvent>((event, emit) async {
      emit(ReelManagerSelectedAlbumMediasLoadingState());
      try {
        final result = await fetchMedias(album: event.currentAlbum, page: 0,);
        emit(ReelManagerSelectedAlbumMeidasSuccessState(medias: result));
      } catch (e) {
        emit(
          ReelManagerSelectedAlbumMediasErrorState(
            message: "Can not fetch medias",
          ),
        );
      }
    });
  }
}
