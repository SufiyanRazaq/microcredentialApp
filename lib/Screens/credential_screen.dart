import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CredentialCreationScreen extends StatefulWidget {
  @override
  _CredentialCreationScreenState createState() =>
      _CredentialCreationScreenState();
}

class _CredentialCreationScreenState extends State<CredentialCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<TextEditingController> _requirementsControllers = [];
  File? _badgeImage;

  Future<void> _createCredential() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<String> requirements = _requirementsControllers
          .map((controller) => controller.text)
          .toList();

      String? badgeImageUrl;
      if (_badgeImage != null) {
        badgeImageUrl = await _uploadBadgeImage();
      }

      await FirebaseFirestore.instance.collection('credentials').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'requirements': requirements,
        'badgeImageUrl': badgeImageUrl,
        'createdBy': user.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credential created successfully')));
      _nameController.clear();
      _descriptionController.clear();
      _requirementsControllers.forEach((controller) => controller.clear());
      setState(() {
        _badgeImage = null;
      });
    }
  }

  Future<void> _pickBadgeImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _badgeImage = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadBadgeImage() async {
    final user = FirebaseAuth.instance.currentUser;
    final fileExtension = _badgeImage!.path.split('.').last;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('badges/${user!.uid}.$fileExtension');
    final uploadTask = storageRef.putFile(_badgeImage!);

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Create Credential',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Credential Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _pickBadgeImage,
              child: const Text('Pick Badge Image'),
            ),
            if (_badgeImage != null)
              Column(
                children: [
                  const SizedBox(height: 15),
                  Image.file(
                    _badgeImage!,
                    height: 100,
                  ),
                ],
              ),
            const SizedBox(height: 15),
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
                            decoration: const InputDecoration(
                              labelText: 'Requirement',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _requirementsControllers.add(TextEditingController());
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  _requirementsControllers.isEmpty
                      ? 'Add Requirement'
                      : 'Add More Requirements',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: _createCredential,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Create Credential',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
