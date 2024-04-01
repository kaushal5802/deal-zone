import 'package:deal_zone/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
         brightness: Brightness.dark,
        primaryColor: Colors.white,
        hintColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Open Sans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      
      ),
      home: const SplashScreen(), // Replace HomeScreen with your actual home screen widget
    );
  }
}
