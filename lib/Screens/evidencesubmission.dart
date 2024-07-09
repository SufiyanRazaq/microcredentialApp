// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EvidenceSubmissionScreen extends StatefulWidget {
  final String credentialId;

  const EvidenceSubmissionScreen({super.key, required this.credentialId});

  @override
  // ignore: library_private_types_in_public_api
  _EvidenceSubmissionScreenState createState() =>
      _EvidenceSubmissionScreenState();
}

class _EvidenceSubmissionScreenState extends State<EvidenceSubmissionScreen> {
  final TextEditingController _evidenceController = TextEditingController();
  PlatformFile? _pickedFile;
  UploadTask? _uploadTask;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _pickedFile = result.files.first;
      });
    }
  }

  Future<void> _submitEvidence() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? fileUrl;
      if (_pickedFile != null) {
        fileUrl = await _uploadFile(_pickedFile!);
      }

      await FirebaseFirestore.instance.collection('submissions').add({
        'userId': user.uid,
        'credentialId': widget.credentialId,
        'evidence': _evidenceController.text,
        'fileUrl': fileUrl,
        'status': 'Pending',
        'submittedAt': Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Evidence submitted successfully')));
      _evidenceController.clear();
      setState(() {
        _pickedFile = null;
      });
    }
  }

  Future<String?> _uploadFile(PlatformFile file) async {
    try {
      final filePath = 'evidence/${file.name}';
      final ref = FirebaseStorage.instance.ref().child(filePath);
      _uploadTask = ref.putFile(File(file.path!));
      final snapshot = await _uploadTask!.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File upload failed: ${e.toString()}')));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Evidence'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _evidenceController,
              decoration: const InputDecoration(
                  labelText: 'Evidence Description',
                  border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Pick Evidence File',
                  style: TextStyle(fontSize: 16)),
            ),
            if (_pickedFile != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Picked file: ${_pickedFile!.name}'),
              ),
            ElevatedButton(
              onPressed: _submitEvidence,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child:
                  const Text('Submit Evidence', style: TextStyle(fontSize: 16)),
            ),
            if (_uploadTask != null)
              StreamBuilder<TaskSnapshot>(
                stream: _uploadTask!.snapshotEvents,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    double progress = data.bytesTransferred / data.totalBytes;
                    return LinearProgressIndicator(value: progress);
                  } else {
                    return Container();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
