import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

import '../../../../profile/Data/model/profile_model.dart';
import '../../../../reels/data/model/reel_model.dart';
import '../../domain/entities/post_entitie.dart';

class PostModel extends PostEntite {
  @override
  const PostModel({
    super.id,
    required super.text,
    super.created_at,
    required super.images,
    required super.numberOfLike,
    required super.author,
    required super.comments,
    required super.isILiked,
    required super.likeIDILike,
    required super.likes,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<String> imageUrls = [];
    for (int i = 0; i < json["images"].length; i++) {
      imageUrls.add(json["images"][i]["image"] as String);
    }
    return PostModel(
      id: json['id'],
      author: ProfileModel.fromJson(json['user']),
      text: json['text'],
      created_at: DateTime.parse(json['created_at']),
      images: imageUrls,
      numberOfLike: json['numberOfLike'],
      comments: (json['comments'] as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList(),
      isILiked: json['isILiked'],
      likes: (json['likes'] as List)
          .map((like) => LikeModel.fromJson(like))
          .toList(),
      likeIDILike: json["likeIdILike"]
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "text": text,
      "upload_images": images,
      // "videos": videos,
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
