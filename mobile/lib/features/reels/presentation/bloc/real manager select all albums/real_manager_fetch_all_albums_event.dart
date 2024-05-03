part of 'real_manager_fetch_all_albums_bloc.dart';

sealed class RealManagerFetchAllAlbumsEvent extends Equatable {
  const RealManagerFetchAllAlbumsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllAlbums extends RealManagerFetchAllAlbumsEvent {
  final BuildContext context;
  const FetchAllAlbums({required this.context});
}
