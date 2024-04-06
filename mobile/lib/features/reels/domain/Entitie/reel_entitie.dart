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

  const ReelEntite(
      {this.author,
      this.comments,
      this.isILiked,
      this.id,
      this.created_at,
      required this.video,
      this.numberOfLike});
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
