import 'package:flutter/material.dart';
import 'package:latihan_responsi/screens/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainscreenPage extends StatefulWidget {
  const MainscreenPage({super.key});

  @override
  State<MainscreenPage> createState() => _MainscreenPageState();
}

class _MainscreenPageState extends State<MainscreenPage> {
  String username;
  SharedPreferences logindata;

  @override
  void initState(){
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contoh Shared Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                logindata.setBool('login', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Loginpage()));
              }, 
              child: Text('Log Out')
              ),
          ],
        ),
      ),
    );
  }
}