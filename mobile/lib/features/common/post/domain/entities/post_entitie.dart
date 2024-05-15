import 'package:equatable/equatable.dart';

import '../../../../profile/Domain/Entite/profile_entitie.dart';
import '../../../../reels/domain/Entitie/reel_entitie.dart';

class PostEntite extends Equatable {
  final int? id;
  final ProfileEntitie author;
  final String text;
  final DateTime? created_at;
  final List<String> images;
  final List<Comment> comments;
  final List<Like> likes;
  final int numberOfLike;
  final bool isILiked;
  final int? likeIDILike;

  const PostEntite({
    required this.author,
    required this.comments,
    required this.isILiked,
    required this.id,
    required this.text,
    required this.created_at,
    required this.images,
    required this.numberOfLike,
    required this.likeIDILike,
    required this.likes,
  });
  @override
  List<Object?> get props => [];
}
