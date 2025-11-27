import 'package:flutter/material.dart';
import 'package:latihan_responsi/controllers/auth_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register"),centerTitle:true, backgroundColor:Colors.blueAccent,foregroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const Text("Daftar Akun Baru", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            
            const SizedBox(height: 20),
            
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
                _authController.register(
                  context,
                  usernameController.text,
                  passwordController.text,
                );
              },
              child: const Text("Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}