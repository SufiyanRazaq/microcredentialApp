import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class VerifyEvidenceScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _approveEvidence(String submissionId) async {
    await _firestore.collection('submissions').doc(submissionId).update({
      'approved': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Evidence'),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('submissions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var submissions = snapshot.data!.docs;
          return ListView.builder(
            itemCount: submissions.length,
            itemBuilder: (context, index) {
              var submission = Submission.fromFirestore(submissions[index]);
              return ListTile(
                title: Text(submission.evidenceUrl),
                subtitle: Text(submission.approved ? 'Approved' : 'Pending'),
                trailing: submission.approved
                    ? null
                    : ElevatedButton(
                        onPressed: () => _approveEvidence(submission.id),
                        child: Text('Approve'),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}

class EvidenceSubmissionScreen extends StatefulWidget {
  final String credentialId;

  EvidenceSubmissionScreen({required this.credentialId});

  @override
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
          SnackBar(content: Text('Evidence submitted successfully')));
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
      appBar: AppBar(title: Text('Submit Evidence')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _evidenceController,
              decoration: InputDecoration(labelText: 'Evidence Description'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick Evidence File'),
            ),
            if (_pickedFile != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Picked file: ${_pickedFile!.name}'),
              ),
            ElevatedButton(
              onPressed: _submitEvidence,
              child: Text('Submit Evidence'),
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

class ReviewSubmissionsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _updateSubmissionStatus(String submissionId, String status,
      String userId, String credentialId) async {
    await _firestore
        .collection('submissions')
        .doc(submissionId)
        .update({'status': status});
    if (status == 'Approved') {
      await _firestore.collection('badges').add({
        'userId': userId,
        'credentialId': credentialId,
        'issuedAt': Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Submissions')),
      body: StreamBuilder(
        stream: _firestore
            .collection('submissions')
            .where('status', isEqualTo: 'Pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var submissions = snapshot.data!.docs;
          return ListView.builder(
            itemCount: submissions.length,
            itemBuilder: (context, index) {
              var submission = submissions[index];
              return ListTile(
                title: Text(submission['evidence']),
                subtitle: Text('User: ${submission['userId']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () => _updateSubmissionStatus(
                          submission.id,
                          'Approved',
                          submission['userId'],
                          submission['credentialId']),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () => _updateSubmissionStatus(
                          submission.id,
                          'Rejected',
                          submission['userId'],
                          submission['credentialId']),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Submission {
  String id;
  String userId;
  String credentialId;
  String evidenceUrl;
  bool approved;

  Submission({
    required this.id,
    required this.userId,
    required this.credentialId,
    required this.evidenceUrl,
    this.approved = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'credentialId': credentialId,
      'evidenceUrl': evidenceUrl,
      'approved': approved,
    };
  }

  Submission.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc['userId'],
        credentialId = doc['credentialId'],
        evidenceUrl = doc['evidenceUrl'],
        approved = doc['approved'];
}
