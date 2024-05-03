part of 'reel_manager_selected_labum_medias_bloc.dart';

sealed class ReelManagerSelectedLabumMediasState extends Equatable {
  const ReelManagerSelectedLabumMediasState();

  @override
  List<Object> get props => [];
}

final class ReelManagerSelectedLabumMediasInitial
    extends ReelManagerSelectedLabumMediasState {}

class ReelManagerSelectedAlbumMeidasSuccessState
    extends ReelManagerSelectedLabumMediasState {
  final List<AssetEntity> medias;

  const ReelManagerSelectedAlbumMeidasSuccessState({
    required this.medias,
  });
}

class ReelManagerSelectedAlbumMediasLoadingState
    extends ReelManagerSelectedLabumMediasState {}

class ReelManagerSelectedAlbumMediasErrorState
    extends ReelManagerSelectedLabumMediasState {
  final String message;
  const ReelManagerSelectedAlbumMediasErrorState({required this.message});
}
