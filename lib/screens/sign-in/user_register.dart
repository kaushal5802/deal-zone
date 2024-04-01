/*
import 'package:deal_zone/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegistrationScreen extends StatefulWidget {
  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sapIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _sapIdController,
                decoration: const InputDecoration(labelText: 'SAP ID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your SAP ID';
                  }
                  if (value.length != 11 || int.tryParse(value) == null) {
                    return 'SAP ID must be 11 numbers';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add email validation here
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  // Add password validation here
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _registerUser();
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      // Save user details to Firestore
      FirebaseFirestore.instance.collection('users').doc(_sapIdController.text).set({
        'sapId': _sapIdController.text,
        'name': _nameController.text,
        'email': _emailController.text,
        // You can add more user details here
      }).then((value) {
        // Show success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('User registered successfully'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close alert dialog
                    // Optionally, navigate to another screen after registration
                    Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => HomeScreen()),
                     );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        // Show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to register user'),
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
      });
    }
  }

  @override
  void dispose() {
    _sapIdController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
*/

import 'package:deal_zone/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sapIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


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
          title: const Text('User Registration'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _sapIdController,
                  decoration: const InputDecoration(labelText: 'SAP ID'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your SAP ID';
                    }
                    if (value.length != 11 || int.tryParse(value) == null) {
                      return 'SAP ID must be 11 numbers';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Add email validation here
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    // Add password validation here
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _registerUser();
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      // Save user details to Firestore
      FirebaseFirestore.instance.collection('users').doc(_sapIdController.text).set({
        'sapId': _sapIdController.text,
        'name': _nameController.text,
        'email': _emailController.text,
        // You can add more user details here
      }).then((value) {
        // Show success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('User registered successfully'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close alert dialog
                    // Optionally, navigate to another screen after registration
                    Navigator.push(
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
      }).catchError((error) {
        // Show error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to register user'),
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
      });
    }
  }

  @override
  void dispose() {
    _sapIdController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
