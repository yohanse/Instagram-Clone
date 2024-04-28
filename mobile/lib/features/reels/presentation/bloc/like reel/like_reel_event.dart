part of 'like_reel_bloc.dart';

sealed class LikeReelEvent extends Equatable {
  const LikeReelEvent();

  @override
  List<Object> get props => [];
}

class LikeReel extends LikeReelEvent {
  final String reelId;

  const LikeReel({required this.reelId});

  @override
  List<Object> get props => [reelId];
}
