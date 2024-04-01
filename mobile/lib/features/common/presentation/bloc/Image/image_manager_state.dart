part of 'image_manager_bloc.dart';

sealed class ImageManagerState extends Equatable {
  const ImageManagerState();

  @override
  List<Object> get props => [];
}

final class ImageManagerInitial extends ImageManagerState {}

// Load Albums

class LoadAlbumsSuccessState extends ImageManagerState {
  final List<AssetPathEntity> albums;
  const LoadAlbumsSuccessState({required this.albums});
}

class LoadAlbumsLoadingState extends ImageManagerState {}

class LoadAlbumsErrorState extends ImageManagerState {
  final String message;
  const LoadAlbumsErrorState({required this.message});
}


// Load Medias

class LoadMediasSuccessState extends ImageManagerState {
  final List<AssetEntity> medias;
  const LoadMediasSuccessState({required this.medias});
}

class LoadMediasLoadingState extends ImageManagerState {}

class LoadMediasErrorState extends ImageManagerState {
  final String message;
  const LoadMediasErrorState({required this.message});
}


// Select Image

class SelectMediasSuccessState extends ImageManagerState {
  final List<AssetEntity> selectedMedias;
  const SelectMediasSuccessState({required this.selectedMedias});
}

class SelectMediasLoadingState extends ImageManagerState {}

class SelectMediasErrorState extends ImageManagerState {
  final String message;
  const SelectMediasErrorState({required this.message});
}
