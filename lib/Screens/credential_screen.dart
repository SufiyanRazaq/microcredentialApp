import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CredentialScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _createCredential() async {
    await _firestore.collection('credentials').add({
      'name': _nameController.text,
      'description': _descriptionController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Credentials'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Credential Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: _createCredential,
              child: Text('Create Credential'),
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
                      return ListTile(
                        title: Text(credentials[index]['name']),
                        subtitle: Text(credentials[index]['description']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
