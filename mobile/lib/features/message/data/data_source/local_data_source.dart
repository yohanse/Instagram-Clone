import 'package:mobile/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MessageLocalDataSource {
  SharedPreferences get prefs;
  String getToken();
}

class MessageLocalDataSourceImpl implements MessageLocalDataSource {
  @override
  String getToken() {
    try {
      return prefs.getString("accessToken")!;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  SharedPreferences prefs;
  MessageLocalDataSourceImpl({required this.prefs});
}