import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:microcredential/Screens/evidence.dart';
import 'package:microcredential/Screens/Authentication/login_screen.dart';
import 'Authentication/profile_screen.dart';
import 'learning_module_screen.dart';
import 'credential_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _logout(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Logout', style: TextStyle(fontSize: 16)),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('credentials').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var credentials = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: credentials.length,
                  itemBuilder: (context, index) {
                    var credential = credentials[index];
                    return ListTile(
                      title: Text(credential['name']),
                      subtitle: Text(credential['description']),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EvidenceSubmissionScreen(
                                credentialId: credential.id,
                              ),
                            ),
                          );
                        },
                        child: Text('Submit Evidence'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CredentialCreationScreen()));
            },
            child: Text('Manage Credentials'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LearningModuleScreen()));
            },
            child: Text('Learning Modules'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
