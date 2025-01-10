import 'dart:convert';

import 'package:mobile/features/message/data/data_source/local_data_source.dart';
import 'package:mobile/features/message/data/models/message_model.dart';
import 'package:mobile/features/profile/Data/model/profile_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';

abstract class MessageRemoteDataSource {
  MessageLocalDataSource get messageLocalDataSource;
  Future<List<ProfileModel>> getUsers();
  Future<List<MessageModel>> getMessages(receiverId);
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  @override
  final MessageLocalDataSource messageLocalDataSource;

  const MessageRemoteDataSourceImpl({required this.messageLocalDataSource});

  @override
  Future<List<ProfileModel>> getUsers() async {
    String url = "http://192.168.43.57:8000/instagram/historyMessage/";

    final responseData = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT ${messageLocalDataSource.getToken()}",
      },
    );
    if (responseData.statusCode == 200) {
      final response = jsonDecode(responseData.body);
      List<ProfileModel> result = [];
      for (int i = 0; i < response.length; i++) {
        result.add(ProfileModel.fromJson(response[i]));
      }
      return result;
    }
    throw ServerException();
  }

  @override
  Future<List<MessageModel>> getMessages(receiverId) async {
    String url =
        "http://192.168.43.57:8000/instagram/messages/?receiver_id=$receiverId";

    final responseData = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT ${messageLocalDataSource.getToken()}",
      },
    );
    if (responseData.statusCode == 200) {
      final response = jsonDecode(responseData.body);
      List<MessageModel> result = [];
      for (int i = 0; i < response.length; i++) {
        result.add(MessageModel.fromJson(response[i]));
      }
      return result;
    }
    throw ServerException();
  }
}
