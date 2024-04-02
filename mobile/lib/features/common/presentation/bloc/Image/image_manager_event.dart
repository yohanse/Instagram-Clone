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
  final List<AssetPathEntity> albums;
  final Set<AssetEntity> selectedMedias;
  const LoadMedias(
      {required this.albums, required this.currentAlbum, required this.selectedMedias,});
}

class SelecteMedia extends ImageManagerEvent {
  final AssetPathEntity? currentAlbum;
  final List<AssetPathEntity> albums;
  final Set<AssetEntity> selectedMedias;
  final List<AssetEntity> medias;

  const SelecteMedia({
    required this.medias,
    required this.currentAlbum,
    required this.albums,
    required this.selectedMedias,
  });
}
