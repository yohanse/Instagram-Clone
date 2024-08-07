import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/common/presentation/bloc/Image/image_manager_bloc.dart';
import 'package:mobile/features/common/presentation/page/ImagePickerErrorPage.dart';
import 'package:mobile/features/common/presentation/page/ImagePickerPageSuccess.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ImageManagerBloc>(context).add(LoadAlbums());
    return BlocConsumer<ImageManagerBloc, ImageManagerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ImageManagerSuccessState) {
          return ImagePickerSuccessPage(state: state);
        } else if (state is ImageManagerErrorState) {
          return ImagePickerErrorPage(text: "Error !!!!");
        }
        return ImagePickerErrorPage(text: "Loading !!!!");
      },
    );
  }
}



// StaggeredGrid.count(
//               crossAxisCount: 3,
//               mainAxisSpacing: 4,
//               crossAxisSpacing: 1,
//               children: [
//                 StaggeredGridTile.count(
//                   crossAxisCellCount: 3,
//                   mainAxisCellCount: 2,
                  // child: state is ImageManagerSuccessState &&
                  //         state.selectedMedias.isNotEmpty
                  //     ? FadeInImage(
                  //         image: AssetEntityImageProvider(
                  //             state.selectedMedias.last),
                  //         placeholder: MemoryImage(kTransparentImage),
                  //       )
                  //     : Container(
                  //         color: Colors.black,
                  //         child: Center(
                  //           child: Text(
                  //             "No Image Selected.",
                  //             style: TextStyle(
                  //               color: Colors.white10,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
//                 ),
//                 StaggeredGridTile.count(
//                   crossAxisCellCount: 3,
//                   mainAxisCellCount: 0.3,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Row(
//                       children: [
//                         DropdownButton<AssetPathEntity>(
//                           value: state is ImageManagerSuccessState &&
//                                   state.currentAlbum != null
//                               ? state.currentAlbum
//                               : null,
//                           items: state is ImageManagerSuccessState
//                               ? state.albums
//                                   .map(
//                                     (album) => DropdownMenuItem(
//                                       child: Text(
//                                         album.name,
//                                       ),
//                                       value: album,
//                                     ),
//                                   )
//                                   .toList()
//                               : [],
//                           onChanged: (album) {
//                             BlocProvider.of<ImageManagerBloc>(context).add(
//                               LoadMedias(
//                                 currentAlbum: album as AssetPathEntity,
//                                 albums: state is ImageManagerSuccessState
//                                     ? state.albums
//                                     : [],
//                                 selectedMedias: state is ImageManagerSuccessState
//                                     ? state.selectedMedias
//                                     : {},
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 StaggeredGridTile.count(
//                   crossAxisCellCount: 3,
//                   mainAxisCellCount: 2.8,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 5,
//                       ),
//                       itemCount: state is ImageManagerSuccessState
//                           ? state.medias.length
//                           : 0,
//                       itemBuilder: (context, index) {
//                         if (state is ImageManagerSuccessState) {
//                           return GestureDetector(
//                             onTap: () {
//                               Set<AssetEntity> updatedSelectedMedias =
//                                   Set.from(state.selectedMedias);
//                               updatedSelectedMedias.add(state.medias[index]);
//                               BlocProvider.of<ImageManagerBloc>(context).add(
//                                 SelecteMedia(
//                                   medias: state.medias,
//                                   currentAlbum: state.currentAlbum,
//                                   albums: state.albums,
//                                   selectedMedias: updatedSelectedMedias,
//                                 ),
//                               );
//                             },
//                             child: FadeInImage(
//                               image:
//                                   AssetEntityImageProvider(state.medias[index]),
//                               placeholder: MemoryImage(kTransparentImage),
//                             ),
//                           );
//                         }
//                         return Container();
//                       },
//                     ),
//                   ),
//                 ),
//                 StaggeredGridTile.count(
//                   crossAxisCellCount: 3,
//                   mainAxisCellCount: 0.4,
//                   child: CustomTabBar(),
//                 ),
//               ],
//             ),
