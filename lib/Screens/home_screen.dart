import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:microcredential/Screens/Admin/adminCredentialsScreen.dart';
import 'package:microcredential/Screens/evidencesubmission.dart';
import 'Authentication/profile_screen.dart';
import 'learning_module_screen.dart';
import 'credential_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Widget _buildMenuButton(BuildContext context, String title, IconData icon,
      VoidCallback onPressed) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onTap: onPressed,
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
      ),
    );
  }

  Future<Map<String, dynamic>> _getCreatorInfo(String userId) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();
    return {
      'name': userDoc['name'],
      'image': userDoc['profileImageUrl'] ?? '',
    };
  }

  Widget _buildCredentialCard(BuildContext context, DocumentSnapshot credential,
      bool canSubmitEvidence) {
    String createdById = credential['createdBy'];
    bool isAdminCredential = createdById == 'Admin';

    return FutureBuilder<Map<String, dynamic>>(
      future: isAdminCredential ? null : _getCreatorInfo(createdById),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        String createdByName =
            isAdminCredential ? 'Admin' : snapshot.data?['name'] ?? '';
        String createdByImage =
            isAdminCredential ? '' : snapshot.data?['image'] ?? '';
        List<dynamic> requirements = credential['requirements'] ?? [];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: createdByImage.isNotEmpty
                          ? NetworkImage(createdByImage)
                          : null,
                      child: createdByImage.isEmpty
                          ? const Icon(Icons.person, size: 20)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      createdByName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  credential['name'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  credential['description'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Requirements:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ...requirements.map((requirement) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '- $requirement',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                if (canSubmitEvidence)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EvidenceSubmissionScreen(
                              credentialId: credential.id,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Submit Evidence',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection('credentials')
                    .where('createdBy', isEqualTo: user?.uid)
                    .where('isVerified', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var credentials = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: credentials.length,
                    itemBuilder: (context, index) {
                      var credential = credentials[index];
                      bool canSubmitEvidence = !credential['isVerified'];

                      return _buildCredentialCard(
                          context, credential, canSubmitEvidence);
                    },
                  );
                },
              ),
            ),
            _buildMenuButton(
              context,
              'Submit Evidence',
              Icons.upload_file,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EvidenceSubmissionScreen(
                    credentialId: 'credentials',
                  ),
                ),
              ),
            ),
            _buildMenuButton(
              context,
              'User Submission Screen',
              Icons.admin_panel_settings,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserSubmissionsScreen(),
                ),
              ),
            ),
            _buildMenuButton(
              context,
              'Admin Credentials',
              Icons.admin_panel_settings,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminCredentialsScreen(),
                ),
              ),
            ),
            _buildMenuButton(
              context,
              'Manage Credentials',
              Icons.badge,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CredentialCreationScreen()),
              ),
            ),
            _buildMenuButton(
              context,
              'Learning Modules',
              Icons.school,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LearningModuleScreen()),
              ),
            ),
            _buildMenuButton(
              context,
              'Profile',
              Icons.person,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserCredentialsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Widget _buildCredentialCard(
      BuildContext context, DocumentSnapshot credential) {
    List<dynamic> requirements = credential['requirements'] ?? [];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              credential['name'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              credential['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Requirements:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...requirements.map((requirement) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '- $requirement',
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EvidenceSubmissionScreen(
                        credentialId: credential.id,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Submit Evidence',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

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
          'My Credentials',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('credentials')
            .where('createdBy', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var credentials = snapshot.data!.docs;
          return ListView.builder(
            itemCount: credentials.length,
            itemBuilder: (context, index) {
              var credential = credentials[index];
              return FutureBuilder(
                future: _firestore
                    .collection('submissions')
                    .where('credentialId', isEqualTo: credential.id)
                    .where('userId', isEqualTo: user?.uid)
                    .get(),
                builder: (context, submissionSnapshot) {
                  if (submissionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!submissionSnapshot.hasData ||
                      submissionSnapshot.data!.docs.isEmpty) {
                    return _buildCredentialCard(context, credential);
                  } else {
                    return Container();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

class UserSubmissionsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _deleteCredential(String credentialId) async {
    await _firestore.collection('credentials').doc(credentialId).delete();
  }

  Future<void> _checkRejectionStatus(
      BuildContext context, DocumentSnapshot submission) async {
    if (submission['status'] == 'Rejected') {
      await _deleteCredential(submission['credentialId']);
      await _firestore.collection('submissions').doc(submission.id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Your evidence for credential ${submission['credentialId']} has been rejected.')),
      );
    }
  }

  Future<List<DocumentSnapshot>> _getVerifiedCredentials(String userId) async {
    QuerySnapshot submissionsSnapshot = await _firestore
        .collection('submissions')
        .where('userId', isEqualTo: userId)
        .get();

    List<DocumentSnapshot> verifiedCredentials = [];

    for (var submission in submissionsSnapshot.docs) {
      var submissionData = submission.data() as Map<String, dynamic>?;
      if (submissionData == null) continue;

      var credentialId = submissionData['credentialId'] as String;
      DocumentSnapshot credentialSnapshot =
          await _firestore.collection('credentials').doc(credentialId).get();

      if (credentialSnapshot.exists) {
        var credentialData = credentialSnapshot.data() as Map<String, dynamic>?;
        if (credentialData != null && credentialData['isVerified'] == true) {
          verifiedCredentials.add(credentialSnapshot);
        }
      }
    }

    return verifiedCredentials;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Verified Credentials'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _getVerifiedCredentials(user!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          var credentials = snapshot.data ?? [];
          return ListView.builder(
            itemCount: credentials.length,
            itemBuilder: (context, index) {
              var credential = credentials[index];
              var credentialData = credential.data() as Map<String, dynamic>?;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        credentialData?['name'] ?? 'No name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        credentialData?['description'] ?? 'No description',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      if (credentialData != null &&
                          credentialData.containsKey('badgeImageUrl'))
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image:
                                  NetworkImage(credentialData['badgeImageUrl']),
                              fit: BoxFit.cover,
                            ),
                          ),
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

class VerifiedSubmissionsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _getCreatorInfo(String userId) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();
    return {
      'name': userDoc['name'],
      'image': userDoc['profileImageUrl'] ?? '',
    };
  }

  Widget _buildCredentialCard(
      BuildContext context, DocumentSnapshot credential) {
    String createdById = credential['createdBy'];
    bool isAdminCredential = createdById == 'Admin';

    return FutureBuilder<Map<String, dynamic>>(
      future: isAdminCredential ? null : _getCreatorInfo(createdById),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        String createdByName =
            isAdminCredential ? 'Admin' : snapshot.data?['name'] ?? '';
        String createdByImage =
            isAdminCredential ? '' : snapshot.data?['image'] ?? '';
        List<dynamic> requirements = credential['requirements'] ?? [];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: createdByImage.isNotEmpty
                          ? NetworkImage(createdByImage)
                          : null,
                      child: createdByImage.isEmpty
                          ? const Icon(Icons.person, size: 20)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      createdByName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  credential['name'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  credential['description'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Requirements:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ...requirements.map((requirement) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '- $requirement',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verified Submissions'),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('credentials')
            .where('isVerified', isEqualTo: true)
            .where('createdBy', isNotEqualTo: 'Admin')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var credentials = snapshot.data!.docs;
          return ListView.builder(
            itemCount: credentials.length,
            itemBuilder: (context, index) {
              var credential = credentials[index];
              return _buildCredentialCard(context, credential);
            },
          );
        },
      ),
    );
  }
}
