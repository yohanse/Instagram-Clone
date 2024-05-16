part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostEvent {}

class LikePostEvent extends PostEvent {
  final int postId;
  const LikePostEvent({required this.postId});
}

class UnLikePostEvent extends PostEvent {
  final int postId, likeId;
  const UnLikePostEvent({required this.postId, required this.likeId});
}

class CommentPostEvent extends PostEvent {
  final int postId;
  final String content;
  const CommentPostEvent({required this.postId, required this.content});
}
