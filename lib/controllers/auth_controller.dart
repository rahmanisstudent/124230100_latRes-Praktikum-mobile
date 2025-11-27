import 'package:flutter/material.dart';
import 'package:latihan_responsi/services/session_service.dart';
import 'package:latihan_responsi/views/dashboard_view.dart';
import 'package:latihan_responsi/views/login_view.dart';

class AuthController {
  final SessionService _sessionService = SessionService();

  // --- LOGIKA REGISTER ---
  Future<void> register(BuildContext context, String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan Password tidak boleh kosong')),
      );
      return;
    }

    // Simpan data ke SharedPreferences
    await _sessionService.saveUser(username, password);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi Berhasil! Silakan Login.')),
      );
      Navigator.pop(context); // Kembali ke halaman Login
    }
  }

  // --- LOGIKA LOGIN ---
  Future<void> login(BuildContext context, String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi username dan password')),
      );
      return;
    }

    // Cek apakah data cocok dengan yang diregistrasikan
    bool isValid = await _sessionService.validateUser(username, password);

    if (isValid) {
      // Jika cocok, simpan status login (sesi)
      await _sessionService.saveSession(username);

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardView()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Berhasil!')),
        );
      }
    } else {
      // Jika tidak cocok atau belum register
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Gagal! Pastikan sudah Register atau cek password.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // --- LOGIKA LOGOUT ---
  Future<void> logout(BuildContext context) async {
    await _sessionService.clearSession();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }
}