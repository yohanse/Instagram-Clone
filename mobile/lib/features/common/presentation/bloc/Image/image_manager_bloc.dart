import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/utility/services/fetch_albums.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

part 'image_manager_event.dart';
part 'image_manager_state.dart';

class ImageManagerBloc extends Bloc<ImageManagerEvent, ImageManagerState> {
  ImageManagerBloc() : super(ImageManagerInitial()) {
    Future<void> grantPermissions() async {
      try {
        // Check if permissions are already granted
        final bool videosGranted = await Permission.videos.isGranted;
        final bool photosGranted = await Permission.photos.isGranted;

        // If permissions are not granted, request them
        if (!photosGranted || !videosGranted) {
          final Map<Permission, PermissionStatus> statuses = await [
            Permission.videos,
            Permission.photos,
          ].request();

          // If permissions are permanently denied, open app settings
          if (statuses[Permission.videos] ==
                  PermissionStatus.permanentlyDenied ||
              statuses[Permission.photos] ==
                  PermissionStatus.permanentlyDenied) {
            // Open app settings to allow users to grant permissions
            await openAppSettings();
          }
        }
      } catch (e) {
        // Handle any exceptions that occur during permission handling
        debugPrint('Error granting permissions: $e');
      }
    }

    Future<List<AssetPathEntity>> fetchAlbums() async {
      try {
        // Ensure permissions are granted before fetching albums
        await grantPermissions();

        // Fetch the list of asset paths (albums)
        List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();

        return albums;
      } catch (e) {
        // Handle any exceptions that occur during album fetching
        debugPrint('Error fetching albums: $e');
        throw Exception();
      }
    }

    Future<List<AssetEntity>> fetchMedias({
      required AssetPathEntity album, // The album from which to fetch media
      required int page, // The page number of media to fetch
    }) async {
      List<AssetEntity> medias = []; // List to hold fetched media items

      try {
        // Get a list of asset entities from the specified album and page
        final List<AssetEntity> entities =
            await album.getAssetListPaged(page: page, size: 30);

        // Loop through each asset entity and create corresponding Media objects
        for (AssetEntity entity in entities) {
          // Add the created Media object to the list
          medias.add(entity);
        }
        return medias;
      } catch (e) {
        // Handle any exceptions that occur during fetching
        debugPrint('Error fetching media: $e');
        throw Exception();
      }
    }

    on<LoadAlbums>((event, emit) async {
      emit(LoadAlbumsLoadingState());
      try {
        List<AssetPathEntity> albums = await fetchAlbums();
        emit(LoadAlbumsSuccessState(albums: albums));
      } catch (e) {
        emit(LoadAlbumsErrorState(message: e.toString()));
      }
    });

    on<LoadMedias>((event, emit) async {
      emit(LoadMediasLoadingState());
      try {
        List<AssetEntity> medias =
            await fetchMedias(album: event.currentAlbum, page: 1);
        emit(LoadMediasSuccessState(medias: medias));
      } catch (e) {
        emit(LoadAlbumsErrorState(message: e.toString()));
      }
    });

    on<SelecteMedia>((event, emit) {
      emit(SelectMediasLoadingState());
      emit(SelectMediasSuccessState(selectedMedias: event.selectedmedias));
    });
  }
}
