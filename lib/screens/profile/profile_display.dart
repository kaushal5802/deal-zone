import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deal_zone/screens/profile/edit_profile.dart';
import 'package:deal_zone/screens/sign-in/sign_in.dart';
import 'package:flutter/widgets.dart';

class ProfileDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('profiles').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Assuming there's only one document in the collection
          var profile = snapshot.data!.docs[0].data() as Map<String, dynamic>;

          // Fetch currently signed-in user
          User? user = _auth.currentUser;

          return ListView(
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              _buildProfileItem(
                icon: Icons.email,
                label: 'Email',
                value: user?.email ?? 'No Email',
              ),
              const SizedBox(height: 20),
              _buildProfileItem(
                icon: Icons.account_circle,
                label: 'SAP ID',
                value: '${profile['sapId']}',
              ),
              const SizedBox(height: 20),
              _buildProfileItem(
                icon: Icons.person,
                label: 'Name',
                value: '${profile['name']}',
              ),
              const SizedBox(height: 20),
              _buildProfileItem(
                icon: Icons.school,
                label: 'Programme',
                value: '${profile['programme']}',
              ),
              const SizedBox(height: 20),
              _buildProfileItem(
                icon: Icons.business,
                label: 'Branch',
                value: '${profile['branch']}',
              ),
              const SizedBox(height: 20),
              _buildProfileItem(
                icon: Icons.phone,
                label: 'Contact Number',
                value: '${profile['contactNumber']}',
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                            onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.purple,
                             // Set text color to white
                              side: const BorderSide(color: Colors.purple),
                              fixedSize: const Size(5, 10),
                              minimumSize: const Size(100, 50),
                            ),
                            child: const Text('Log Out',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            fontFamily: 'Monospace',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                
                            ),
                            
                            ),
                          ),
              ),
              const SizedBox(height: 20),
              
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Center(
                  child: Text(
                    'Made with ❤️ by \n Kaushal, Divy, Dharini',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 16.0, 
                    color: Colors.white, 
                    fontWeight:FontWeight.bold
                    
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileItem({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
