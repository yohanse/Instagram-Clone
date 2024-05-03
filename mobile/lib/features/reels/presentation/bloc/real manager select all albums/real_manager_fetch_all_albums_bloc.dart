import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

part 'real_manager_fetch_all_albums_event.dart';
part 'real_manager_fetch_all_albums_state.dart';

class RealManagerFetchAllAlbumsBloc extends Bloc<RealManagerFetchAllAlbumsEvent,
    RealManagerFetchAllAlbumsState> {
  RealManagerFetchAllAlbumsBloc() : super(RealManagerFetchAllAlbumsInitial()) {
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
        final List<AssetPathEntity> albums =
            await PhotoManager.getAssetPathList();

        return albums;
      } catch (e) {
        // Handle any exceptions that occur during album fetching
        debugPrint('Error fetching albums: $e');
        throw Exception();
      }
    }

    on<FetchAllAlbums>((event, emit) async {
      emit(RealManagerFetchAllAlbumsLoadingState());
      try {
        final result = await fetchAlbums();
        emit(RealManagerFetchAllAlbumsSuccessState(albums: result));
      } catch (e) {
        emit(
          RealManagerFetchAllAlbumsErrorState(message: "can not fetch albums"),
        );
      }
    });
  }
}
