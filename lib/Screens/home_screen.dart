import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'learning_module_screen.dart';
import 'credential_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
      ),
      body: Column(
        children: [
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
                    return ListTile(
                      title: Text(credentials[index]['name']),
                      subtitle: Text(credentials[index]['description']),
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
