import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

import '../../../profile/Data/model/profile_model.dart';

class ReelModel extends ReelEntite {
  @override
  const ReelModel({
    super.id,
    super.created_at,
    required super.video,
    super.numberOfLike,
    super.author,
    super.comments,
    super.isILiked,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'],
      author: ProfileModel.fromJson(json['user']),
      created_at: DateTime.parse(json['created_at']),
      video: json['video']['video'],
      numberOfLike: json['numberOfLike'],
      comments: (json['comments'] as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList(),
      likes: (json['comments'] as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList(),
      isILiked: json['isILiked'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "video": video
    };
  }
}

class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.content,
    required super.created_at,
    required super.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      content: json['content'],
      created_at: DateTime.parse(json['created_at']),
      user: ProfileModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> tojson() {
    return {};
  }
}

class LikeModel extends Like {
  const LikeModel({
    required super.id,
    required super.created_at,
    required super.user,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      created_at: DateTime.parse(json['created_at']),
      user: ProfileModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> tojson() {
    return {};
  }
}
