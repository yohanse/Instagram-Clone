import 'package:mobile/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  SharedPreferences get prefs;
  String getAccessToken();
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  @override
  String getAccessToken() {
    if (prefs.getString("accessToken") == null) {
      throw NoTokenException();
    }
    return prefs.getString("accessToken")!;
  }

  @override
  SharedPreferences prefs;
  PostLocalDataSourceImpl({required this.prefs});
}
