import 'package:mobile/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  SharedPreferences get prefs;
  Future<bool> cacheToken( {required String accessToken, required String refreshToken});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<bool> cacheToken(
      {required String accessToken, required String refreshToken}) async {
    try {
      await prefs.setString('accessToken', accessToken);
      await prefs.setString('refreshToken', refreshToken);
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  SharedPreferences prefs;
  AuthLocalDataSourceImpl({required this.prefs});
}
