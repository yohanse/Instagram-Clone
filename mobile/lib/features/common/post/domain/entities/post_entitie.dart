import 'package:equatable/equatable.dart';

import '../../../../profile/Domain/Entite/profile_entitie.dart';

class PostEntite extends Equatable {
  final int? id;
  final String text;
  final DateTime? created_at;
  final int? numberOfLike;
  final List<String> images;
  final List<String>? videos;
  final ProfileEntitie? author;
  final List<Comment>? comments;
  final bool? isILiked;
  final int? likeIdILike;
  const PostEntite(
      {this.author,
      this.comments,
      this.isILiked,
      this.id,
      required this.text,
      this.created_at,
      required this.images,
      this.videos,
      this.numberOfLike,
      this.likeIdILike});
  @override
  List<Object?> get props => [];
}

class Comment extends Equatable {
  final int id;
  final String content;
  final DateTime created_at;
  final ProfileEntitie user;
  const Comment(
      {required this.id,
      required this.content,
      required this.created_at,
      required this.user});
  @override
  List<Object?> get props => [];
}
