import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewSubmissionsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _updateSubmissionStatus(String submissionId, String status,
      String userId, String credentialId) async {
    await _firestore
        .collection('submissions')
        .doc(submissionId)
        .update({'status': status});
    if (status == 'Approved') {
      DocumentSnapshot credentialDoc =
          await _firestore.collection('credentials').doc(credentialId).get();
      if (credentialDoc.exists) {
        String badgeImageUrl = credentialDoc['badgeImageUrl'];
        await _firestore.collection('credentials').doc(credentialId).update({
          'isVerified': true,
        });
        await _firestore.collection('badges').add({
          'userId': userId,
          'credentialId': credentialId,
          'badgeImageUrl': badgeImageUrl,
          'issuedAt': Timestamp.now(),
        });
      }
    }
  }

  Future<void> _rejectSubmission(
      String submissionId, String credentialId) async {
    await _firestore.collection('submissions').doc(submissionId).update({
      'status': 'Rejected',
    });
    await _firestore.collection('credentials').doc(credentialId).delete();
  }

  Future<Map<String, dynamic>?> _getCredentialDetails(
      String credentialId) async {
    DocumentSnapshot credentialDoc =
        await _firestore.collection('credentials').doc(credentialId).get();
    if (credentialDoc.exists) {
      return credentialDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Review Submissions',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
              return FutureBuilder<Map<String, dynamic>?>(
                future: _getCredentialDetails(submission['credentialId']),
                builder: (context, credentialSnapshot) {
                  if (credentialSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (credentialSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${credentialSnapshot.error}'));
                  }
                  var credential = credentialSnapshot.data;
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (credential != null)
                            Text(
                              'Credential: ${credential['name']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const SizedBox(height: 10),
                          Text(
                            submission['evidenceDescription'],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          if (submission.data().containsKey('fileUrl'))
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(submission['fileUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check_circle,
                                    color: Colors.green),
                                onPressed: () => _updateSubmissionStatus(
                                    submission.id,
                                    'Approved',
                                    submission['userId'],
                                    submission['credentialId']),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.cancel, color: Colors.red),
                                onPressed: () => _rejectSubmission(
                                    submission.id, submission['credentialId']),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
