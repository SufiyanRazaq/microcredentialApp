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
  _EvidenceSubmissionScreenState createState() =>
      _EvidenceSubmissionScreenState();
}

class _EvidenceSubmissionScreenState extends State<EvidenceSubmissionScreen> {
  final TextEditingController _evidenceController = TextEditingController();
  PlatformFile? _pickedFile;
  UploadTask? _uploadTask;
  bool _isSubmitting = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _pickedFile = result.files.first;
      });
    }
  }

  Future<void> _submitEvidence() async {
    if (_evidenceController.text.isEmpty || _pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')));
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? fileUrl;
        if (_pickedFile != null) {
          fileUrl = await _uploadFile(_pickedFile!);
        }

        await FirebaseFirestore.instance.collection('submissions').add({
          'userId': user.uid,
          'credentialId': widget.credentialId,
          'evidenceDescription': _evidenceController.text,
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting evidence: $e')));
    } finally {
      setState(() {
        _isSubmitting = false;
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
  void dispose() {
    _evidenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Submit Evidence',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
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
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            if (_pickedFile != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Picked file: ${_pickedFile!.name}'),
              ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitEvidence,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Submit Evidence',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
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
