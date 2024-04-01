import 'package:deal_zone/screens/home/home_screen.dart';
import 'package:deal_zone/screens/sign-in/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSigningIn = false;

  Future<void> _signIn() async {
    setState(() {
      _isSigningIn = true;
    });
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _isSigningIn = false;
      });
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Signin Success'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close alert dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        _isSigningIn = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Error, while registering'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close alert dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  Future<void> _resetPassword(BuildContext context) async {
    // Get the currently signed-in user
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Send password reset email to the user's email address
        await _auth.sendPasswordResetEmail(email: user.email!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent. Check your inbox.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send password reset email.'),
          ),
        );
      }
    }
  }


  void _navigateToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
        hintColor: Colors.white,
        fontFamily: 'Monospace',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(  
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Implement forgot password functionality here
                        _resetPassword(context);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _isSigningIn
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: ElevatedButton(
                          onPressed: _signIn,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.purple, // Set text color to white
                            side: const BorderSide(color: Colors.purple), // Add border color
                          ),
                          child: const Text('Sign In'),
                        ),
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: _navigateToRegisterScreen,
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


