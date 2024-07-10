import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:microcredential/Screens/evidencesubmission.dart';

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
  bool _isCreating = false;

  Future<void> _createCredential() async {
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _requirementsControllers.any((controller) => controller.text.isEmpty) ||
        _badgeImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')));
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Retrieve user information from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        String userName = userDoc['name'];

        List<String> requirements = _requirementsControllers
            .map((controller) => controller.text)
            .toList();

        String? badgeImageUrl;
        if (_badgeImage != null) {
          badgeImageUrl = await _uploadBadgeImage();
        }

        var credentialRef =
            await FirebaseFirestore.instance.collection('credentials').add({
          'name': _nameController.text,
          'description': _descriptionController.text,
          'requirements': requirements,
          'badgeImageUrl': badgeImageUrl,
          'createdBy': userName, // Store the user name instead of the user ID
          'isVerified': false,
        });

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credential created successfully')));
        _nameController.clear();
        _descriptionController.clear();
        _requirementsControllers.forEach((controller) => controller.clear());
        setState(() {
          _badgeImage = null;
        });

        // Navigate to EvidenceSubmissionScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EvidenceSubmissionScreen(
              credentialId: credentialRef.id,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating credential: $e')));
    } finally {
      setState(() {
        _isCreating = false;
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
      body: SingleChildScrollView(
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
            ElevatedButton.icon(
              onPressed: _pickBadgeImage,
              icon: const Icon(Icons.image),
              label: const Text('Pick Badge Image'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (_badgeImage != null)
              Column(
                children: [
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _badgeImage!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 15),
            Column(
              children: List.generate(_requirementsControllers.length, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _requirementsControllers[index],
                          decoration: InputDecoration(
                            labelText: 'Requirement ${index + 1}',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _requirementsControllers.removeAt(index);
                        });
                      },
                    ),
                  ],
                );
              }),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _requirementsControllers.add(TextEditingController());
                  });
                },
                icon: const Icon(Icons.add),
                label: Text(_requirementsControllers.isEmpty
                    ? 'Add Requirement'
                    : 'Add More Requirements'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: _isCreating ? null : _createCredential,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isCreating
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Create Credential',
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
