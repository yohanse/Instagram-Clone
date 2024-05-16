import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/features/common/post/data/datasources/local_data_source.dart';
import 'package:mobile/features/common/post/data/models/post_model.dart';

import '../../../../reels/data/model/reel_model.dart';

abstract class PostRemoteDataSource {
  PostLocalDataSource get postLocalDataSource;
  Future<List<PostModel>> getAllPost();
  Future<PostModel> addPost(PostModel postModel);
  Future<LikeModel> likePost({required int postId});
  Future<bool> unlikePost({required int postId, required int likeId});
  Future<CommentModel> commentPost({required int postId, required String content});
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  final PostLocalDataSource postLocalDataSource;

  PostRemoteDataSourceImpl({required this.postLocalDataSource});

  @override
  Future<List<PostModel>> getAllPost() async {
    String url = "http://192.168.43.57:8000/instagram/posts/";

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
      List<PostModel> result = [];
      for (int i = 0; i < response.length; i++) {
        result.add(PostModel.fromJson(response[i]));
      }
      return result;
    }
    throw ServerException();
  }

  @override
  Future<PostModel> addPost(PostModel postModel) async {
    String url = "http://192.168.43.57:8000/instagram/posts/";
    final Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization':
          "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
    };
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.fields['text'] = postModel.text;
    for (int i = 0; i < postModel.images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        'upload_images',
        postModel.images[i],
      ));
    }
    final response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(await response.stream.bytesToString());
      return PostModel.fromJson(responseData);
    }
    throw ServerException();
  }

  @override
  Future<LikeModel> likePost({required int postId}) async {
    String url = "http://192.168.43.57:8000/instagram/posts/$postId/likes/";

    final responseData = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
      },
    );
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      final response = jsonDecode(responseData.body);
      return LikeModel.fromJson(response);
    }
    throw ServerException();
  }

  @override
  Future<bool> unlikePost({required int postId, required int likeId}) async {
    String url =
        "http://192.168.43.57:8000/instagram/posts/$postId/likes/$likeId/";

    final responseData = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
      },
    );

    if (responseData.statusCode == 200 || responseData.statusCode == 204) {
      return true;
    }
    throw ServerException();
  }
  @override
  Future<CommentModel> commentPost({required int postId, required String content}) async {
    String url = 'http://192.168.43.57:8000/instagram/posts/$postId/comments/';
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
