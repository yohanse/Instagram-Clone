import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/reels/presentation/bloc/real%20manager%20select%20all%20albums/real_manager_fetch_all_albums_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/real%20manager%20selected%20album/real_manager_selected_album_bloc.dart';
import 'package:mobile/features/reels/presentation/bloc/reel%20manger%20selected%20album%20medias/reel_manager_selected_labum_medias_bloc.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SelectReelVideoPage extends StatelessWidget {
  const SelectReelVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RealManagerFetchAllAlbumsBloc>(context).add(
      FetchAllAlbums(context: context),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          color: Colors.white,
          onPressed: () {
            context.go("/reel");
          },
        ),
        title: Center(
          child: Text(
            "New Reel",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  margin: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 85,
            child: Column(
              children: [
                BlocBuilder<RealManagerSelectedAlbumBloc,
                    RealManagerSelectedAlbumState>(
                  builder: ((context, state) {
                    if (state is RealManagerSelectedAlbumSuccessState) {
                      return GestureDetector(
                        child: Row(
                          children: [
                            Text(
                              state.selectedAlbum.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      );
                    }
                    return Text(
                      "No Video",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: Expanded(
                    child: BlocBuilder<ReelManagerSelectedLabumMediasBloc,
                        ReelManagerSelectedLabumMediasState>(
                      builder: (context, state) {
                        if (state
                            is ReelManagerSelectedAlbumMeidasSuccessState) {
                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                              ),
                              itemCount: state.medias.length,
                              itemBuilder: (context, index) {
                                return FadeInImage(
                                  image: AssetEntityImageProvider(
                                      state.medias[index]),
                                  placeholder: MemoryImage(kTransparentImage),
                                  fit: BoxFit.fill,
                                );
                              });
                        }
                        return Center(
                          child: Text(
                            "No Media",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class SelectReelVideoPage extends StatelessWidget {
//   final SelectReelVideoSucessState state;
//   const SelectReelVideoPage({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(

//         body: BlocBuilder<IsMultipleSelectedBloc, IsMultipleSelectedState>(
//           builder: (context, stateNew) {
//             return Container(
//               color: Colors.black,
//               padding: const EdgeInsets.symmetric(horizontal: 14.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     flex: 40,
//                     child: state.selectedMedias.isNotEmpty
//                         ? FadeInImage(
//                             image: AssetEntityImageProvider(
//                                 state.selectedMedias.last),
//                             placeholder: MemoryImage(kTransparentImage),
//                           )
//                         : Container(
//                             color: Colors.grey,
//                           ),
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         DropdownButtonHideUnderline(
//                           child: DropdownButton<AssetPathEntity>(
//                             dropdownColor: Colors.black,
//                             value: state.currentAlbum,
//                             items: state.albums
//                                 .map(
//                                   (album) => DropdownMenuItem(
//                                     child: Text(
//                                       album.name,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     value: album,
//                                   ),
//                                 )
//                                 .toList(),
//                             onChanged: (album) {
//                               BlocProvider.of<ImageManagerBloc>(context).add(
//                                 LoadMedias(
//                                   currentAlbum: album as AssetPathEntity,
//                                   albums: state.albums,
//                                   selectedMedias: state.selectedMedias,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 BlocProvider.of<IsMultipleSelectedBloc>(context)
//                                     .add(
//                                   ChangeIsSelected(
//                                       isSelected: stateNew is Selected),
//                                 );
//                                 BlocProvider.of<ImageManagerBloc>(context).add(
//                                   SelecteMedia(
//                                     medias: state.medias,
//                                     currentAlbum: state.currentAlbum,
//                                     albums: state.albums,
//                                     selectedMedias: {state.selectedMedias.last},
//                                   ),
//                                 );
//                               },
//                               child: CustomSelectMultipleWidget(
//                                 isSelected: stateNew is Selected,
//                               ),
//                             ),
//                             SizedBox(width: 5),
//                             const OpenCameraWidget(),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
                  
//                             child: Stack(
//                               children: [
//                                 FadeInImage(
//                                   image: AssetEntityImageProvider(
//                                       state.medias[index]), // Placeholder image
//                                   placeholder: MemoryImage(kTransparentImage),
//                                   fit: BoxFit.fill,
//                                 ),
//                                 Visibility(
//                                   visible: state.selectedMedias
//                                       .contains(state.medias[index]),
//                                   child: Container(
//                                     color: Colors.grey.withOpacity(
//                                         0.6), // Semi-transparent black overlay
//                                   ),
//                                 ),
//                               ],
//                             ));
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//         floatingActionButton: CustomTabBar(),
//       ),
//     );
//   }
// }
