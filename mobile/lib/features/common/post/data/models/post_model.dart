import '../../domain/entities/post_entitie.dart';

class PostModel extends PostEntite {
  const PostModel({
    required super.id,
    required super.text,
    required super.created_at,
    required super.images,
    required super.videos,
    required super.numberOfLike,
    required super.author,
    required super.comments,
    required super.isILiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      text: json['text'],
      created_at: DateTime.parse(json['created_at']),
      images: json['images'], 
      videos: json['videos'],
      numberOfLike: json['numberOfLike'],
      author: ProfileModel.fromJson(json['author']),
      comments: (json['comments'] as List).map((comment) => CommentModel.fromJson(comment)).toList(), // Handle null or non-list 'comments'
      isILiked: json['isILiked'],
    );
  }
}

class ProfileModel extends Profile {
  const ProfileModel({
    required super.user_id,
    required super.name,
    required super.profile_image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user_id: json['user_id'],
      name: json['name'],
      profile_image: json['profile_image'],
    );
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
}