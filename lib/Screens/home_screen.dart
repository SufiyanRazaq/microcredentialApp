import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                stream: _firestore.collection('credentials').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var credentials = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: credentials.length,
                    itemBuilder: (context, index) {
                      var credential = credentials[index];
                      bool canSubmitEvidence =
                          credential['createdBy'] == user?.uid &&
                              !credential['isVerified'];

                      return _buildCredentialCard(
                          context, credential, canSubmitEvidence);
                    },
                  );
                },
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
