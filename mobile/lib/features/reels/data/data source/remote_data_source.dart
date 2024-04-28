import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart';

import '../model/reel_model.dart';
import 'local_data_source.dart';

abstract class ReelRemoteDataSource {
  ReelLocalDataSource get reelLocalDataSource;
  Future<List<ReelModel>> getAllReel();
}

class ReelRemoteDataSourceImpl implements ReelRemoteDataSource {
  @override
  final ReelLocalDataSource reelLocalDataSource;

  ReelRemoteDataSourceImpl({required this.reelLocalDataSource});

  
  @override
  Future<List<ReelModel>> getAllReel() async {
    String url = "http://192.168.43.57:8000/instagram/reels/";
    print("yohanse");
    final responseData = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
      },
    );
    print(responseData.body);
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
}
