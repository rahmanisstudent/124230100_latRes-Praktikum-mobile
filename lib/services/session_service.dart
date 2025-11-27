import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // Key untuk data sesi (Login Status)
  static const String _keyCurrentUsername = 'current_username';
  static const String _keyIsLogin = 'is_login';

  // Key untuk data Pendaftaran (Simulasi Database di SharedPrefs)
  static const String _keyRegisteredUsername = 'registered_username';
  static const String _keyRegisteredPassword = 'registered_password';

  // --- BAGIAN SESI (LOGIN/LOGOUT/CURRENT USER) ---

  // 1. Simpan sesi user yang sedang aktif
  Future<void> saveSession(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCurrentUsername, username);
    await prefs.setBool(_keyIsLogin, true);
  }

  // 2. Ambil username yang sedang login (INI YANG DITAMBAHKAN)
  Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentUsername);
  }

  // 3. Cek apakah ada user yang sedang login
  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLogin) ?? false;
  }

  // 4. Hapus sesi (Logout)
  Future<void> clearSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCurrentUsername);
    await prefs.setBool(_keyIsLogin, false);
  }

  // --- BAGIAN REGISTER (PENYIMPANAN AKUN) ---

  // 5. Simpan data pendaftaran (Register)
  Future<void> saveUser(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyRegisteredUsername, username);
    await prefs.setString(_keyRegisteredPassword, password);
  }

  // 6. Validasi Login (Cocokkan input dengan data tersimpan)
  Future<bool> validateUser(String inputUser, String inputPass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUser = prefs.getString(_keyRegisteredUsername);
    String? savedPass = prefs.getString(_keyRegisteredPassword);

    // Cek apakah data cocok
    if (savedUser != null && savedPass != null) {
      return (inputUser == savedUser && inputPass == savedPass);
    }
    return false; // Belum ada user terdaftar
  }
}