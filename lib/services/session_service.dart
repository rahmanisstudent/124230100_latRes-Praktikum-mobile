import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _keyCurrentUsername = 'current_username';
  static const String _keyIsLogin = 'is_login';

  static const String _keyRegisteredUsername = 'registered_username';
  static const String _keyRegisteredPassword = 'registered_password';

  Future<void> saveSession(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCurrentUsername, username);
    await prefs.setBool(_keyIsLogin, true);
  }

  Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentUsername);
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLogin) ?? false;
  }

  Future<void> clearSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCurrentUsername);
    await prefs.setBool(_keyIsLogin, false);
  }

  Future<void> saveUser(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyRegisteredUsername, username);
    await prefs.setString(_keyRegisteredPassword, password);
  }

  Future<bool> validateUser(String inputUser, String inputPass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUser = prefs.getString(_keyRegisteredUsername);
    String? savedPass = prefs.getString(_keyRegisteredPassword);

    if (savedUser != null && savedPass != null) {
      return (inputUser == savedUser && inputPass == savedPass);
    }
    return false;
  }
}