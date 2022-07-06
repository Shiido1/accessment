import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SessionManager._internal();

  SharedPreferences? sharedPreferences;

  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  static SessionManager get instance => _instance;

  Future<void> initializeSession() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String keyAuthToken = 'auth_token';

  String get authToken => sharedPreferences!.getString(keyAuthToken) ?? '';

  set authToken(String authToken) =>
      sharedPreferences!.setString(keyAuthToken, authToken);

  
}
