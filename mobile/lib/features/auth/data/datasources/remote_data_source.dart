import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/features/auth/data/datasources/local_data_source.dart';
import 'package:mobile/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  AuthLocalDataSource get authLocalDataSource;
  Future<bool> checkConfirmation(
      {required String email, required String confimationCode});
  Future<bool> checkEmail({required String email});
  Future<bool> checkUsername({required String username});
  Future<bool> signUp({required AuthModel user});
  Future<bool> logIn({required String username, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  final AuthLocalDataSource authLocalDataSource;

  AuthRemoteDataSourceImpl({required this.authLocalDataSource});

  @override
  Future<bool> checkConfirmation(
      {required String email, required String confimationCode}) async {
    String url = "http://192.168.43.57:8000/core/checkCode/";
    final responseData = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode({'email': email, 'confirmation_code': confimationCode}));
    final response = jsonDecode(responseData.body);
    print(response);
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      return response['valid'];
    }
    throw ServerException();
  }

  @override
  Future<bool> checkEmail({required String email}) async {
    String url = "http://192.168.43.57:8000/core/checkEmail/";
    final responseData = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}));
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      return true;
    }
    if (jsonDecode(responseData.body)['error'] == 'Email already exists') {
      throw EmailAlreadyExistException();
    }
    if (responseData.statusCode == 400) {
      throw WrongEmailFormatException();
    }
    throw ServerException();
  }

  @override
  Future<bool> checkUsername({required String username}) async {
    String url = "http://192.168.43.57:8000/core/checkUsername/";
    print("remote");

    final responseData = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username}));
    print(responseData.body);
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      return true;
    }
    if (jsonDecode(responseData.body)['error'] == 'username already exists') {
      throw UsernameAlreadyExistException();
    }
    throw ServerException();
  }

  @override
  Future<bool> signUp({required AuthModel user}) async {
    String url = "http://192.168.43.57:8000/auth/users/";
    print("remote");

    final responseData = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.tojson()));
    print(responseData.body);
    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      return true;
    }
    throw ServerException();
  }

  @override
  Future<bool> logIn(
      {required String username, required String password}) async {
    String url = "http://192.168.43.57:8000/auth/jwt/create/";

    final responseData = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}));

    if (responseData.statusCode == 200 || responseData.statusCode == 201) {
      authLocalDataSource.cacheToken(
        accessToken: jsonDecode(responseData.body)["access"],
        refreshToken: jsonDecode(responseData.body)["refresh"],
      );
      return true;
    }
    if (responseData.statusCode == 401) {
      throw UsernameAndPasswordDoesNotMatchException();
    }
    throw ServerException();
  }
}
