import 'package:mobile/features/message/Domain/entitie/message_entitie.dart';
import 'package:mobile/features/profile/Data/model/profile_model.dart';

class MessageModel extends MessageEntitie {
  final String id;
  const MessageModel(
      {required super.sender,
      required super.receiver,
      required super.content,
      required super.link,
      required super.createdAt,
      required this.id});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: "${json['id']}",
      sender: ProfileModel.fromJson(json["sender"]),
      receiver: ProfileModel.fromJson(json["receiver"]),
      content: json["content"],
      link: json["file"],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> tojson() {
    return {};
  }
}


// {
//         "id": 57,
//         "sender": {
//             "user_id": 1,
//             "name": "abebe",
//             "profile_image": "http://192.168.43.57:8000/media/profile/images/profile.webp"
//         },
//         "receiver": {
//             "user_id": 2,
//             "name": "yohanse",
//             "profile_image": "http://192.168.43.57:8000/media/profile/images/123.jpg"
//         },
//         "content": ";mfdknlknlknlkflknlkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkfn",
//         "created_at": "2024-05-11T19:25:07.786220Z",
//         "file": null,
//         "type": "chat.message"
//     },
