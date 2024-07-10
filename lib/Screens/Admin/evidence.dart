import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VerifyEvidenceScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _approveEvidence(String submissionId) async {
    await _firestore.collection('submissions').doc(submissionId).update({
      'status': 'Approved',
    });
  }

  Future<void> _rejectEvidence(String submissionId, String credentialId) async {
    await _firestore.collection('submissions').doc(submissionId).update({
      'status': 'Rejected',
    });
    await _firestore.collection('credentials').doc(credentialId).delete();
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
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    submission.evidenceUrl,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    submission.approved ? 'Approved' : 'Pending',
                    style: TextStyle(
                      color: submission.approved ? Colors.green : Colors.red,
                    ),
                  ),
                  trailing: submission.approved
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check_circle,
                                  color: Colors.green),
                              onPressed: () => _approveEvidence(submission.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.cancel, color: Colors.red),
                              onPressed: () => _rejectEvidence(
                                  submission.id, submission.credentialId),
                            ),
                          ],
                        ),
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

  Future<void> _rejectSubmission(
      String submissionId, String credentialId) async {
    await _firestore.collection('submissions').doc(submissionId).update({
      'status': 'Rejected',
    });
    await _firestore.collection('credentials').doc(credentialId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Submissions'),
        backgroundColor: Colors.teal,
      ),
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
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    submission['evidenceDescription'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'User: ${submission['userId']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () => _updateSubmissionStatus(
                            submission.id,
                            'Approved',
                            submission['userId'],
                            submission['credentialId']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () => _rejectSubmission(
                            submission.id, submission['credentialId']),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
