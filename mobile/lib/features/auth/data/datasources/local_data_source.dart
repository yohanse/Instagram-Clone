import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  SharedPreferences get prefs;
  Future<void> cacheToken({String token});
}
