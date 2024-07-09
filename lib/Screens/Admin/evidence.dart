import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Verify Evidence'),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder(
        stream: _firestore.collection('submissions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Approve',
                            style: TextStyle(fontSize: 16)),
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
      appBar: AppBar(title: const Text('Review Submissions')),
      body: StreamBuilder(
        stream: _firestore
            .collection('submissions')
            .where('status', isEqualTo: 'Pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
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
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => _updateSubmissionStatus(
                          submission.id,
                          'Approved',
                          submission['userId'],
                          submission['credentialId']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
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
