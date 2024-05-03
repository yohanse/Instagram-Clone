import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/real%20manager%20selected%20album/real_manager_selected_album_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

part 'real_manager_fetch_all_albums_event.dart';
part 'real_manager_fetch_all_albums_state.dart';

class RealManagerFetchAllAlbumsBloc extends Bloc<RealManagerFetchAllAlbumsEvent,
    RealManagerFetchAllAlbumsState> {
  RealManagerFetchAllAlbumsBloc() : super(RealManagerFetchAllAlbumsInitial()) {
    Future<List<AssetEntity>> fetchMedias({
      required List<AssetPathEntity>
          albums, // The album from which to fetch media
      required int page, // The page number of media to fetch
    }) async {
      List<AssetEntity> videos = []; // List to hold fetched media items

      try {
        // Get a list of asset entities from the specified album and page
        for (AssetPathEntity album in albums) {
          final List<AssetEntity> entities =
              await album.getAssetListRange(start: 0, end: 80);

          final AssetEntity video = entities
              .where((entity) => entity.type == AssetType.video)
              .toList()[0];
          videos.add(video);
        }

        return videos;
      } catch (e) {
        // Handle any exceptions that occur during fetching
        debugPrint('Error fetching media: $e');
        throw Exception();
      }
    }

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
        final List<AssetPathEntity> newAlbum = [];

        for (AssetPathEntity album in albums) {
          final List<AssetEntity> entities =
              await album.getAssetListRange(start: 0, end: 80);

          final List<AssetEntity> video = entities
              .where((entity) => entity.type == AssetType.video)
              .toList();
          if (video.isNotEmpty) {
            newAlbum.add(album);
          }
          
        }
        return newAlbum;
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

        BlocProvider.of<RealManagerSelectedAlbumBloc>(event.context).add(
          SelecteReelAlbum(selectedAlbum: result[0], context: event.context),
        );
        final profiles = await fetchMedias(albums: result, page: 0);
        emit(RealManagerFetchAllAlbumsSuccessState(
            albums: result, profiles: profiles));
      } catch (e) {
        emit(
          RealManagerFetchAllAlbumsErrorState(
            message: "can not fetch albums",
          ),
        );
      }
    });
  }
}
