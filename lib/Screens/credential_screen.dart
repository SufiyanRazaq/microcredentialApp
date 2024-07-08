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
  List<TextEditingController> _requirementsControllers = [];

  Future<void> _createCredential() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<String> requirements = _requirementsControllers
          .map((controller) => controller.text)
          .toList();

      await FirebaseFirestore.instance.collection('credentials').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'requirements': requirements,
        'createdBy': user.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credential created successfully')));
      _nameController.clear();
      _descriptionController.clear();
      _requirementsControllers.forEach((controller) => controller.clear());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _requirementsControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Credential')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Credential Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _requirementsControllers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _requirementsControllers[index],
                            decoration:
                                const InputDecoration(labelText: 'Requirement'),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            _requirementsControllers.removeAt(index);
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _requirementsControllers.add(TextEditingController());
                });
              },
              child: Text(_requirementsControllers.isEmpty
                  ? 'Add Requirement'
                  : 'Add More Requirements'),
            ),
            ElevatedButton(
              onPressed: _createCredential,
              child: const Text('Create Credential'),
            ),
          ],
        ),
      ),
    );
  }
}
