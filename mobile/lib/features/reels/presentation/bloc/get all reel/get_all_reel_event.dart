part of 'get_all_reel_bloc.dart';

sealed class GetAllReelEvent extends Equatable {
  const GetAllReelEvent();

  @override
  List<Object> get props => [];
}

class GetAllReelsEvent extends GetAllReelEvent {}

class GetAllLikeReelEvent extends GetAllReelEvent {
  final String reelId;

  const GetAllLikeReelEvent({required this.reelId});

  @override
  List<Object> get props => [reelId];
}

class GetAllCommentReelEvent extends GetAllReelEvent {
  final String reelId;
  final String content;

  const GetAllCommentReelEvent({required this.reelId, required this.content});

  @override
  List<Object> get props => [reelId];
}
