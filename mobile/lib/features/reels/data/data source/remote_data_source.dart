import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart';

import '../model/reel_model.dart';
import 'local_data_source.dart';

abstract class ReelRemoteDataSource {
  ReelLocalDataSource get reelLocalDataSource;
  Future<List<ReelModel>> getAllReel();
  Future<ReelModel> getReel(String reelId);
  Future<bool> likeReel(String reelId);
  Future<bool> unlikeReel(String reelId, String likeId);
  Future<CommentModel> commentReel(String reelId, String content);
}

class ReelRemoteDataSourceImpl implements ReelRemoteDataSource {
  @override
  final ReelLocalDataSource reelLocalDataSource;

  ReelRemoteDataSourceImpl({required this.reelLocalDataSource});

  @override
  Future<List<ReelModel>> getAllReel() async {
    String url = "http://192.168.43.57:8000/instagram/reels/";
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
      List<ReelModel> result = [];
      for (int i = 0; i < response.length; i++) {
        result.add(ReelModel.fromJson(response[i]));
      }
      return result;
    }
    throw ServerException();
  }

  @override
  Future<bool> likeReel(String reelId) async {
    String url = 'http://192.168.43.57:8000/instagram/reels/$reelId/likes/';
    final responseData = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
      },
    );
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      return true;
    }
    throw ServerException();
  }

  @override
  Future<ReelModel> getReel(String reelId) async {
    String url = "http://192.168.43.57:8000/instagram/reels/$reelId/";
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
      return ReelModel.fromJson(response);
    }
    throw ServerException();
  }

  @override
  Future<bool> unlikeReel(String reelId, String likeId) async {
    String url = 'http://192.168.43.57:8000/instagram/reels/$reelId/likes/$likeId';
    final responseData = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
      },
    );
    print(jsonDecode(responseData.body));
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      return true;
    }
    throw ServerException();
  }

  @override
  Future<CommentModel> commentReel(String reelId, String content) async {
    String url = 'http://192.168.43.57:8000/instagram/reels/$reelId/comments/';
    final responseData = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization':
            "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
      },
      body: {"content": content},
    );
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      final response = jsonDecode(responseData.body);
      return CommentModel.fromJson(response);
    }
    throw ServerException();
  }
}
