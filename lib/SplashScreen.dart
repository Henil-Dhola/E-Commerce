import 'dart:async';
import 'package:ecommerceassingment/LoginPage.dart';
import 'package:ecommerceassingment/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay navigation to the home screen by 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserCheck()), // Replace HomeScreen with your desired screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // You can set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Your logo or splash image
            Image.asset(
              'assets/image/cart.png', // Replace with your image asset
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            // Your app name or text
            Text(
              'Shopping',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // You can set your desired text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
