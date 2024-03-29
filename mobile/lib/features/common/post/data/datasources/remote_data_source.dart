import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/features/common/post/data/datasources/local_data_source.dart';
import 'package:mobile/features/common/post/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  PostLocalDataSource get postLocalDataSource;
  Future<List<PostModel>> getAllPost();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  final PostLocalDataSource postLocalDataSource;

  PostRemoteDataSourceImpl({required this.postLocalDataSource});

  @override
  Future<List<PostModel>> getAllPost() async {
    String url = "http://127.0.0.1:8000/instagram/posts/";
    final responseData = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': postLocalDataSource.getAccessToken()
      },
    );
    if (responseData.statusCode == 200) {
      List<dynamic> response = jsonDecode(responseData.body)["data"];
      List<PostModel> result =
          response.map((post) => PostModel.fromJson(post)).toList();
      return result;
    }
    throw ServerException();
  }
}
