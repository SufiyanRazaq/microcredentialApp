import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class CredentialCreationScreen extends StatefulWidget {
  @override
  _CredentialCreationScreenState createState() =>
      _CredentialCreationScreenState();
}

class _CredentialCreationScreenState extends State<CredentialCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();

  Future<void> _createCredential() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('credentials').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'requirements': _requirementsController.text,
        'createdBy': user.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credential created successfully')));
      _nameController.clear();
      _descriptionController.clear();
      _requirementsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Credential')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            TextField(
              controller: _requirementsController,
              decoration: InputDecoration(labelText: 'Requirements'),
            ),
            ElevatedButton(
              onPressed: _createCredential,
              child: Text('Create Credential'),
            ),
          ],
        ),
      ),
    );
  }
}

class Credential {
  final String id;
  final String name;
  final String description;
  final String requirements;
  final String createdBy;

  Credential(
      {required this.id,
      required this.name,
      required this.description,
      required this.requirements,
      required this.createdBy});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'requirements': requirements,
      'createdBy': createdBy,
    };
  }

  factory Credential.fromMap(String id, Map<String, dynamic> map) {
    return Credential(
      id: id,
      name: map['name'],
      description: map['description'],
      requirements: map['requirements'],
      createdBy: map['createdBy'],
    );
  }
}
