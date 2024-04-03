import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart';

import '../model/profile_model.dart';

abstract class ProfileRemoteDataSource {
  // ProfileLocalDataSource get profileLocalDataSource;
  Future<ProfileModel> getProfile();
}

class PostRemoteDataSourceImpl implements ProfileRemoteDataSource {

  PostRemoteDataSourceImpl();
  
  @override
  Future<ProfileModel> getProfile() async {
    String url = "http://192.168.43.57:8000/instagram/me/";
    final responseData = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE2OTA4MTc5LCJpYXQiOjE3MTE3MjQxNzksImp0aSI6Ijk4ZTIzNDZhZTc4YTRmYTQ5MTA2OTgzYTliMzEzNWZmIiwidXNlcl9pZCI6MX0.Wo_mbQQMV4cNPYbTKtWCrOCzBsHSJ0BCYMRgx8ajl3k",
      },
    );

    if (responseData.statusCode == 200) {
      final response = jsonDecode(responseData.body);
      return ProfileModel.fromJson(response);
    }
    throw ServerException();
  }

  
}
