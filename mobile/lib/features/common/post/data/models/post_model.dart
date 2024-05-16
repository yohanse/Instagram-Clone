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
    super.videos,
    super.numberOfLike,
    super.author,
    super.comments,
    super.isILiked,
    super.likeIdILike,
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
      videos: const [],
      numberOfLike: json['numberOfLike'],
      comments: (json['comments'] as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList(),
      isILiked: json['isILiked'],
      likeIdILike: json["likeIdILike"],
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


