import 'package:deal_zone/screens/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Monospace'
            )
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.lock),
                    ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    helperText: '8 characters minimum',
                    icon: Icon(Icons.lock),
                    ),
                  obscureText: true, // Hide password input
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 30.0,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: _emailController.text, password: _passwordController.text);
                            
                              // Successful registration - navigate to EditProfileScreen
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('The password provided is too weak.'),
                          ),
                        );
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('The account already exists for that email.'),
                          ),
                        );
                         } else {
                        print(e); // Handle other errors
                      }
                    } catch (e) {
                      print(e); // Handle other errors
                    }
                  }
                },
                        style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // Set text color to white
                    backgroundColor: Colors.purple, // Set background color to purple
                    side: const BorderSide(color: Colors.purple), // Set border color to purple
                    minimumSize: const Size(150, 50), // Set minimum width and height for button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Maintain rounded corners
                    ),
                                ),
                        child: const Text('Register'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
