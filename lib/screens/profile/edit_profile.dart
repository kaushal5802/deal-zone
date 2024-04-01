import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _sapId = '';
  String _name = '';
  String _programme = '';
  String _branch = '';
  String _contactNumber = '';


  Future<void> _saveProfile() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      // Save the profile data to Firestore
      try {
        await FirebaseFirestore.instance.collection('profiles').add({
          'sapId': _sapId,
          'name': _name,
          'programme': _programme,
          'branch': _branch,
          'contactNumber': _contactNumber,
        
        });

        // Navigate back to previous screen
        Navigator.pop(context);
      } catch (e) {
        print('Error saving profile: $e');
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'SAP ID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your SAP ID';
                  }
                  return null;
                },
                onSaved: (value) => _sapId = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Programme'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your programme';
                  }
                  return null;
                },
                onSaved: (value) => _programme = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Branch'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your branch';
                  }
                  return null;
                },
                onSaved: (value) => _branch = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
                onSaved: (value) => _contactNumber = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
