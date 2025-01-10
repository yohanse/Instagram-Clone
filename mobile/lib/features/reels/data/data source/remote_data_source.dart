import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

import '../model/reel_model.dart';
import 'local_data_source.dart';

abstract class ReelRemoteDataSource {
  ReelLocalDataSource get reelLocalDataSource;
  Future<List<ReelModel>> getAllReel();
  Future<ReelModel> getReel(String reelId);
  Future<Like> likeReel(String reelId);
  Future<bool> unlikeReel(String reelId, String likeId);
  Future<CommentModel> commentReel(String reelId, String content);
  Future<ReelModel> addReel(String filePath, String content);
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
            "JWT ${reelLocalDataSource.getToken()}",
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
  Future<Like> likeReel(String reelId) async {
    String url = 'http://192.168.43.57:8000/instagram/reels/$reelId/likes/';
    final responseData = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT ${reelLocalDataSource.getToken()}",
      },
    );
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      return LikeModel.fromJson(jsonDecode(responseData.body));
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
            "JWT ${reelLocalDataSource.getToken()}",
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
    String url =
        'http://192.168.43.57:8000/instagram/reels/$reelId/likes/$likeId/';
    final responseData = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization':
            "JWT ${reelLocalDataSource.getToken()}",
      },
    );
    if (responseData.statusCode == 200 || responseData.statusCode == 204) {
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
            "JWT ${reelLocalDataSource.getToken()}",
      },
      body: {"content": content},
    );
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      final response = jsonDecode(responseData.body);
      return CommentModel.fromJson(response);
    }
    throw ServerException();
  }

  @override
  Future<ReelModel> addReel(String filePath, String content) async {
    String url = 'http://192.168.43.57:8000/instagram/reels/';
    final Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization':
          "JWT ${reelLocalDataSource.getToken()}",
    };
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['content'] = content;
    request.files.add(
      await http.MultipartFile.fromPath(
        'upload_video',
        filePath,
      ),
    );
    final response = await request.send();
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(await response.stream.bytesToString());
      return ReelModel.fromJson(responseData);
    }
    throw ServerException();
  }
}
