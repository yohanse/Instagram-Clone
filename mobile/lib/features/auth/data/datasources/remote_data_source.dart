import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<bool> checkConfirmation(
      {required String email, required String confimationCode});
  Future<bool> checkEmail({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<bool> checkConfirmation(
      {required String email, required String confimationCode}) async {
    String url = "http://127.0.0.1:8000/core";
    final responseData = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode({'email': email, 'confirmation_code': confimationCode}));
    final response = jsonDecode(responseData.body);
    print(response);

    return response['valid'];
  }

  @override
  Future<bool> checkEmail({required String email}) async {
    String url = "http://127.0.0.1:8000/core";
    final responseData = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}));
    final response = jsonDecode(responseData.body);
    print(response);

    return response['email'];
  }
}
