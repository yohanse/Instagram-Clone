part of 'real_manager_selected_album_bloc.dart';

sealed class RealManagerSelectedAlbumState extends Equatable {
  const RealManagerSelectedAlbumState();
  
  @override
  List<Object> get props => [];
}

final class RealManagerSelectedAlbumInitial extends RealManagerSelectedAlbumState {}

class RealManagerSelectedAlbumSuccessState extends RealManagerSelectedAlbumState {
  final AssetPathEntity selectedAlbum;

  const RealManagerSelectedAlbumSuccessState(
      {required this.selectedAlbum,});
}

class RealManagerSelectedAlbumLoadingState extends RealManagerSelectedAlbumState {}

class RealManagerSelectedAlbumErrorState extends RealManagerSelectedAlbumState {
  final String message;
  const RealManagerSelectedAlbumErrorState({required  this.message});
}