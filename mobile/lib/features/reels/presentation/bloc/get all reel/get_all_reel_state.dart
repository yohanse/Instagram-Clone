part of 'get_all_reel_bloc.dart';

sealed class GetAllReelState extends Equatable {
  const GetAllReelState();

  @override
  List<Object> get props => [];
}

final class GetAllReelInitial extends GetAllReelState {}

class GetAllReelLoadedState extends GetAllReelState {
  final List<ReelEntite> reels;
  const GetAllReelLoadedState({required this.reels});
  @override
  List<Object> get props => [reels];
}


class GetAllReelLoadingState extends GetAllReelState {}


class GetAllReelErrorState extends GetAllReelState {
  final String message;
  const GetAllReelErrorState({required this.message});
}
