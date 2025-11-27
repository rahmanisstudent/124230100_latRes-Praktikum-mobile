import 'package:flutter/material.dart';
import 'package:latihan_responsi/screens/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Example'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login Form",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsetsGeometry.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsGeometry.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                String username = username_controller.text;
                String password = password_controller.text;

                if (username != 'budi' && password != '123') {
                  print('successfull');
                  logindata.setBool('login', false);
                  logindata.setString('username', username);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainscreenPage()));
                }
              }, 
              child: Text('Log In'),
              ),
          ],
        ),
      ),
    );
  }

  late SharedPreferences logindata;
  late bool newuser;
  
  @override
  void initState(){
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login')??true);
    print(newuser);
    if (newuser == false){
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MainscreenPage()));
    }
  }
  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
}