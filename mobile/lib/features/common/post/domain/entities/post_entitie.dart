import 'package:equatable/equatable.dart';

class PostEntite extends Equatable {
  final int id;
  final String text;
  final DateTime created_at;
  final int numberOfLike;
  final List<String> images, videos;
  final Profile author;
  final List<Comment> comments;
  final bool isILiked;
  const PostEntite(
      {required this.author,
      required this.comments,
      required this.isILiked,
      required this.id,
      required this.text,
      required this.created_at,
      required this.images,
      required this.videos,
      required this.numberOfLike});
  @override
  List<Object?> get props => [];
}

class Profile extends Equatable {
  final int user_id;
  final String name, profile_image;
  const Profile(
      {required this.user_id, required this.name, required this.profile_image});
  @override
  List<Object?> get props => [];
}

class Comment extends Equatable {
  final int id;
  final String content;
  final DateTime created_at;
  final Profile user;
  const Comment(
      {required this.id,
      required this.content,
      required this.created_at,
      required this.user});
  @override
  List<Object?> get props => [];
}