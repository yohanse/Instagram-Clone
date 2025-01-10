import 'package:mobile/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ReelLocalDataSource {
  SharedPreferences get prefs;
  String getToken();
}

class ReelLocalDataSourceImpl implements ReelLocalDataSource {
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
  ReelLocalDataSourceImpl({required this.prefs});
}
