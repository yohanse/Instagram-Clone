import 'package:mobile/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  SharedPreferences get prefs;
  Future<bool> cacheToken({required String token});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<bool> cacheToken({required String token}) async {
    try {
      await prefs.setString('token', token);
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  SharedPreferences prefs;
  AuthLocalDataSourceImpl({required this.prefs});
}
