part of 'image_manager_bloc.dart';

sealed class ImageManagerEvent extends Equatable {
  const ImageManagerEvent();

  @override
  List<Object> get props => [];
}

// class UpdateSelectedMedias extends ImageManagerEvent {}

class LoadAlbums extends ImageManagerEvent {}

class LoadMedias extends ImageManagerEvent {
  final AssetPathEntity currentAlbum;
  const LoadMedias({required this.currentAlbum});
}

class SelecteMedia extends ImageManagerEvent {
  final List<AssetEntity> selectedmedias;

  const SelecteMedia({required this.selectedmedias});
}
