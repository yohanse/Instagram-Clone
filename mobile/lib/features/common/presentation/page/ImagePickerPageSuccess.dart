import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/common/presentation/bloc/Image/image_manager_bloc.dart';
import 'package:mobile/features/common/presentation/bloc/IsMultipleSelected/is_multiple_selected_bloc.dart';
import 'package:mobile/features/common/presentation/widget/CustomSelectMultipleWidget.dart';
import 'package:mobile/features/common/presentation/widget/CustomTabBarScrollable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widget/OpenCameraWidget.dart';

class ImagePickerSuccessPage extends StatelessWidget {
  final ImageManagerSuccessState state;
  const ImagePickerSuccessPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close_rounded),
            color: Colors.white,
            onPressed: () {
              context.go("/");
            },
          ),
          title: Text(
            "New post",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  context.go("/pickImage/post", extra: state.selectedMedias.toList());
                },
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.blue),
                ))
          ],
          backgroundColor: Colors.black,
        ),
        body: BlocBuilder<IsMultipleSelectedBloc, IsMultipleSelectedState>(
          builder: (context, stateNew) {
            return Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 40,
                    child: state.selectedMedias.isNotEmpty
                        ? FadeInImage(
                            image: AssetEntityImageProvider(
                                state.selectedMedias.last),
                            placeholder: MemoryImage(kTransparentImage),
                          )
                        : Container(
                            color: Colors.grey,
                          ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<AssetPathEntity>(
                            dropdownColor: Colors.black,
                            value: state.currentAlbum,
                            items: state.albums
                                .map(
                                  (album) => DropdownMenuItem(
                                    child: Text(
                                      album.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: album,
                                  ),
                                )
                                .toList(),
                            onChanged: (album) {
                              BlocProvider.of<ImageManagerBloc>(context).add(
                                LoadMedias(
                                  currentAlbum: album as AssetPathEntity,
                                  albums: state.albums,
                                  selectedMedias: state.selectedMedias,
                                ),
                              );
                            },
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<IsMultipleSelectedBloc>(context)
                                    .add(
                                  ChangeIsSelected(
                                      isSelected: stateNew is Selected),
                                );
                                BlocProvider.of<ImageManagerBloc>(context).add(
                                  SelecteMedia(
                                    medias: state.medias,
                                    currentAlbum: state.currentAlbum,
                                    albums: state.albums,
                                    selectedMedias: {state.selectedMedias.last},
                                  ),
                                );
                              },
                              child: CustomSelectMultipleWidget(
                                isSelected: stateNew is Selected,
                              ),
                            ),
                            SizedBox(width: 5),
                            const OpenCameraWidget(),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 60,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      ),
                      itemCount: state.medias.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Set<AssetEntity> updatedSelectedMedias =
                                  Set.from(state.selectedMedias);

                              if (stateNew is Selected) {
                                if (updatedSelectedMedias
                                    .contains(state.medias[index])) {
                                  updatedSelectedMedias
                                      .remove(state.medias[index]);
                                } else {
                                  updatedSelectedMedias
                                      .add(state.medias[index]);
                                }
                              } else {
                                updatedSelectedMedias = {state.medias[index]};
                              }

                              BlocProvider.of<ImageManagerBloc>(context).add(
                                SelecteMedia(
                                  medias: state.medias,
                                  currentAlbum: state.currentAlbum,
                                  albums: state.albums,
                                  selectedMedias: updatedSelectedMedias,
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                FadeInImage(
                                  image: AssetEntityImageProvider(
                                      state.medias[index]), // Placeholder image
                                  placeholder: MemoryImage(kTransparentImage),
                                  fit: BoxFit.fill,
                                ),
                                Visibility(
                                  visible: state.selectedMedias
                                      .contains(state.medias[index]),
                                  child: Container(
                                    color: Colors.grey.withOpacity(
                                        0.6), // Semi-transparent black overlay
                                  ),
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: CustomTabBar(),
      ),
    );
  }
}
