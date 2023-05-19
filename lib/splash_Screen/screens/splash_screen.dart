import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sign_up/registration/screens/registration_form_screen.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Replace this with your desired route
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => RegistrationScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FlutterLogo(
            //   size: 100.0,
            // ),
             Image.asset(
                  "assets/image/Ripple-1s-200px.gif",
                  fit: BoxFit.contain,
                ),
            const SizedBox(height: 16.0),
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                  color: Color(0xfffe4e59),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


