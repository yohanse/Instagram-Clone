import 'dart:convert';

import 'package:mobile/features/message/data/data_source/local_data_source.dart';
import 'package:mobile/features/message/data/models/message_model.dart';
import 'package:mobile/features/profile/Data/model/profile_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';

abstract class MessageRemoteDataSource {
  MessageLocalDataSource get messageLocalDataSource;
  Future<List<ProfileModel>> getUsers();
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  @override
  final MessageLocalDataSource messageLocalDataSource;

  const MessageRemoteDataSourceImpl({required this.messageLocalDataSource});

  @override
  Future<List<ProfileModel>> getUsers() async {
    String url = "http://192.168.43.57:8000/instagram/users/";

    final responseData = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
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
}
