import 'package:equatable/equatable.dart';

class PostEntite extends Equatable {
  final String id, text;
  final DateTime created_at;
  final int numberOfLike;
  final List<String> images, videos;
  final Profile author;
  final List<Comment> comments;
  final bool isILiked;
  const PostEntite(
      {
      required this.author,
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
  final String user_id, name, profile_image;
  const Profile(
      {required this.user_id, required this.name, required this.profile_image});
  @override
  List<Object?> get props => [];
}

class Comment extends Equatable {
  final String id, content;
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



// "id": 21,
//         "author": {
//             "bio": "yohanse"
//         },
//         "text": "yohanse",
//         "created_at": "2024-03-25T11:47:20.443134Z",
//         "images": [],
//         "videos": [],
//         "numberOfLike": 0,
//         "comments": [
//             {
//                 "user": {
//                     "user_id": 3,
//                     "name": "lisping",
//                     "profile_image": null
//                 },
//                 "id": 1,
//                 "content": "tfguhewbjfs",
//                 "created_at": "2024-03-25T13:10:12.435768Z"
//             }
//         ],
//         "isILiked": false
