import 'package:flutter/material.dart';
import 'package:latihan_responsi/controllers/auth_controller.dart';
import 'package:latihan_responsi/views/register_view.dart'; // Jangan lupa import ini

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),centerTitle: true, backgroundColor:Colors.blueAccent, foregroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Silakan Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            
            const SizedBox(height: 20),
            
            Container(
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
            
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                _authController.login(
                  context,
                  usernameController.text,
                  passwordController.text,
                );
              },
              child: const Text('Login'),
            ),
            
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterView()),
                );
              },
              child: const Text("Belum punya akun? Daftar di sini"),
            ),
          ],
        ),
      ),
    );
  }
}