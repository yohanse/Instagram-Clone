part of 'get_all_reel_bloc.dart';

sealed class GetAllReelEvent extends Equatable {
  const GetAllReelEvent();

  @override
  List<Object> get props => [];
}

class GetAllReelsEvent extends GetAllReelEvent {}

class GetAllLikeReelEvent extends GetAllReelEvent {
  final String reelId;
  final int reelIndex;
  const GetAllLikeReelEvent({
    required this.reelId,
    required this.reelIndex,
  });

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

class GetAllUnLikeReelEvent extends GetAllReelEvent {
  final String reelId;
  final int reelIndex;
  final int likeId;
  const GetAllUnLikeReelEvent({
    required this.reelId,
    required this.reelIndex,
    required this.likeId,
  });

  @override
  List<Object> get props => [reelId];
}

class GetAllAddReelEvent extends GetAllReelEvent {
  final String filePath;
  final String content;
  const GetAllAddReelEvent({
    required this.content,
    required this.filePath,
  });
}
