part of 'like_reel_bloc.dart';

sealed class LikeReelState extends Equatable {
  const LikeReelState();
  
  @override
  List<Object> get props => [];
}

final class LikeReelInitial extends LikeReelState {}

class LikeReelInProgress extends LikeReelState {}

class LikeReelSuccess extends LikeReelState {}

class LikeReelFailure extends LikeReelState {
  final String message;

  const LikeReelFailure({required this.message});

  @override
  List<Object> get props => [message];
}
