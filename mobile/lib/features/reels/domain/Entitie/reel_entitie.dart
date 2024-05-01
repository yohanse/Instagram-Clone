import 'package:equatable/equatable.dart';
import '../../../profile/Domain/Entite/profile_entitie.dart';

class ReelEntite extends Equatable {
  final int? id;
  final ProfileEntitie? author;
  final DateTime? created_at;
  final String video;
  final List<Comment>? comments;
  final int? numberOfLike;
  final bool? isILiked;
  final List<Like>? likes;

  const ReelEntite(
      {this.author,
      this.comments,
      this.isILiked,
      this.id,
      this.created_at,
      required this.video,
      this.numberOfLike,
      this.likes,
      });
  @override
  List<Object?> get props =>
      [author, comments, id, created_at, video, numberOfLike, isILiked];
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
  List<Object?> get props => [id, content, created_at, user];
}

class Like extends Equatable {
  final int id;
  final DateTime created_at;
  final ProfileEntitie user;
  const Like({required this.id, required this.created_at, required this.user});
  @override
  List<Object?> get props => [id, created_at, user];
}
