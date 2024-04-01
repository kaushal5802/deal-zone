/*
import 'package:deal_zone/screens/home/home_screen.dart';
import 'package:deal_zone/screens/sign-in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // Delay login check slightly for a smoother UI experience
    Future.delayed(const Duration(seconds: 3), () {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() async {
    try {
      final currentUser = await _auth.currentUser;
      setState(() {
        if (currentUser != null) {
          // Navigate to home screen using pushReplacement
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // Navigate to sign-in screen using pushReplacement
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }
      });
    } catch (e) {
      // Handle any errors during login check (optional)
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Your splash screen design (optional)
      body: Center(
        child: CircularProgressIndicator(), // Loading indicator (optional)
      ),
    );
  }
}
*/

import 'package:deal_zone/screens/home/home_screen.dart';
import 'package:deal_zone/screens/sign-in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // Delay login check slightly for a smoother UI experience
    Future.delayed(const Duration(seconds: 3), () {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() async {
    try {
      final currentUser = await _auth.currentUser;
      setState(() {
        if (currentUser != null) {
          // Navigate to home screen using pushReplacement
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          // Navigate to sign-in screen using pushReplacement
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }
      });
    } catch (e) {
      // Handle any errors during login check (optional)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/DealZone_logo.png', // Replace 'your_logo.png' with your image asset path
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
        ),
      ),
    );
  }
}
