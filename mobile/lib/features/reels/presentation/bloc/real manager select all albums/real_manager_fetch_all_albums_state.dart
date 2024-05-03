part of 'real_manager_fetch_all_albums_bloc.dart';

sealed class RealManagerFetchAllAlbumsState extends Equatable {
  const RealManagerFetchAllAlbumsState();
  
  @override
  List<Object> get props => [];
}

final class RealManagerFetchAllAlbumsInitial extends RealManagerFetchAllAlbumsState {}

final class RealManagerFetchAllAlbumsSuccessState extends RealManagerFetchAllAlbumsState {
  final List<AssetPathEntity> albums;

  const RealManagerFetchAllAlbumsSuccessState(
      {required this.albums,});
}

final class RealManagerFetchAllAlbumsLoadingState extends RealManagerFetchAllAlbumsState {}

final class RealManagerFetchAllAlbumsErrorState extends RealManagerFetchAllAlbumsState {
  final String message;
  const RealManagerFetchAllAlbumsErrorState({required  this.message});
}