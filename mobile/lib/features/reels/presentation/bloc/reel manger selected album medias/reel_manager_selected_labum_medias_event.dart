part of 'reel_manager_selected_labum_medias_bloc.dart';

sealed class ReelManagerSelectedLabumMediasEvent extends Equatable {
  const ReelManagerSelectedLabumMediasEvent();

  @override
  List<Object> get props => [];
}


class FetchSlectedAlbumMediasEvent extends ReelManagerSelectedLabumMediasEvent {
  final AssetPathEntity currentAlbum;

  const FetchSlectedAlbumMediasEvent({
    required this.currentAlbum,
  });
}