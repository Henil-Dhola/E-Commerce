import 'package:ecommerceassingment/LoginPage.dart';
import 'package:ecommerceassingment/Pages/HomePage.dart';
import 'package:ecommerceassingment/SplashScreen.dart';
import 'package:ecommerceassingment/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class UserCheck extends StatefulWidget {
  const UserCheck({super.key});

  @override
  State<UserCheck> createState() => _UserCheckState();
}

class _UserCheckState extends State<UserCheck> {


  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;
    String? email=user?.email;
    if (user != null) {
      // If user is not authenticated, navigate to login screen

      // return Welcome(email);
      return HomePage();
    } else {
      // If user is authenticated, navigate to welcome screen
      return LoginPage();
    }


  }
}

