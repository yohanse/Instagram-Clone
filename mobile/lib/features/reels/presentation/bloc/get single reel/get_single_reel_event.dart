part of 'get_single_reel_bloc.dart';

sealed class GetSingleReelEvent extends Equatable {
  const GetSingleReelEvent();

  @override
  List<Object> get props => [];
}

class GetSingleReel extends GetSingleReelEvent {
  final String reelId;

  const GetSingleReel({required this.reelId});

  @override
  List<Object> get props => [reelId];
}