import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/features/common/post/data/datasources/local_data_source.dart';
import 'package:mobile/features/common/post/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  PostLocalDataSource get postLocalDataSource;
  Future<List<PostModel>> getAllPost();
  Future<PostModel> addPost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  final PostLocalDataSource postLocalDataSource;

  PostRemoteDataSourceImpl({required this.postLocalDataSource});

  @override
  Future<List<PostModel>> getAllPost() async {
    String url = "http://192.168.43.57:8000/instagram/posts/";
    print("yohanse");
    final responseData = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': postLocalDataSource.getAccessToken()
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
    print("yohanse");
    final responseData = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': postLocalDataSource.getAccessToken()
      },
      body: postModel.tojson(),
    );

    if (responseData.statusCode == 200) {
      final response = jsonDecode(responseData.body);
      return PostModel.fromJson(response);
    }
    throw ServerException();
  }
}
