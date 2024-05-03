import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/real%20manager%20select%20all%20albums/real_manager_fetch_all_albums_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/real%20manager%20selected%20album/real_manager_selected_album_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:video_player/video_player.dart';

import '../../domain/Entitie/reel_entitie.dart';
import '../bloc/get all reel/get_all_reel_bloc.dart';

import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

void reelAlbumsBottomSheet(BuildContext context) async {
  showSnappingBottomSheet(context, builder: (context) {
    return SnappingBottomSheetDialog(
      cornerRadius: 25,
      color: Color(0xFF262626),
      snapSpec: const SnapSpec(
        initialSnap: 1,
        snap: true,
        snappings: [0, 1],
      ),
      headerBuilder: (context, state) {
        return Container(
          height: 56,
          width: double.infinity,
          padding: EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Select album",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
      builder: (context, state) => BlocBuilder<RealManagerFetchAllAlbumsBloc,
          RealManagerFetchAllAlbumsState>(
        builder: (context, state) {
          if (state is RealManagerFetchAllAlbumsSuccessState) {
            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<RealManagerSelectedAlbumBloc>(context)
                          .add(
                        SelecteReelAlbum(
                          context: context,
                          selectedAlbum: state.albums[index],
                        ),
                      );
                    },
                    child: Card(
                      color: Color(0xFF262626),
                      child: Column(
                        children: [
                          Expanded(
                            child: FadeInImage(
                              image: AssetEntityImageProvider(
                                state.profiles[index],
                              ),
                              height: 300,
                              width: 400,
                              placeholder: MemoryImage(kTransparentImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            state.albums[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: Text(
              "No album contain video",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          );
        },
      ),
    );
  });
}