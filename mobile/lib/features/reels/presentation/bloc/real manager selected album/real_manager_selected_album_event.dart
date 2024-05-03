part of 'real_manager_selected_album_bloc.dart';

sealed class RealManagerSelectedAlbumEvent extends Equatable {
  const RealManagerSelectedAlbumEvent();

  @override
  List<Object> get props => [];
}

class SelecteReelAlbum extends RealManagerSelectedAlbumEvent {
  final AssetPathEntity selectedAlbum;
  final BuildContext context;
  const SelecteReelAlbum({
    required this.selectedAlbum,
    required this.context,
  });
}
