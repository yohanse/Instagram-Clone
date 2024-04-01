import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/features/common/presentation/bloc/Image/image_manager_bloc.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageManagerBloc, ImageManagerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        BlocProvider.of<ImageManagerBloc>(context).add(LoadAlbums());
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.close_rounded),
              title: Text("New post"),
              actions: [Text("Next")],
            ),
            body: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: const [
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: Text("yohanse1"),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: Text("yohanse2"),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: Text("yohanse3"),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: Text("yohanse4"),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 2,
                  child: Text("yohanse5"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
