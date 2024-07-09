import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:badges/badges.dart' as badges;
import 'package:microcredential/Screens/Admin/AdminCredentials.dart';
import 'package:microcredential/Screens/Admin/credentialScreen.dart';
import 'package:microcredential/Screens/Admin/evidence.dart';
import 'package:microcredential/Screens/Admin/profileScreen.dart';

class AdminHomeScreen extends StatelessWidget {
  final String adminName = "Admin"; // Replace with actual admin name if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('submissions')
                    .where('status', isEqualTo: 'Pending')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  }
                  int submissionCount = snapshot.data!.docs.length;
                  return _buildMenuButton(
                    context,
                    'Review Submissions',
                    Icons.assignment,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewSubmissionsScreen()),
                    ),
                    submissionCount,
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildMenuButton(
                context,
                'Create Credentials',
                Icons.badge,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminCredentialCreationScreen()),
                ),
              ),
              const SizedBox(height: 15),
              _buildMenuButton(
                context,
                'Profile',
                Icons.person,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminProfileScreen()),
                ),
              ),
              const SizedBox(height: 15),
              _buildMenuButton(
                context,
                'Your Credentials',
                Icons.view_list,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AdminCredentialsScreen(adminName: adminName)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, String title, IconData icon, VoidCallback onPressed,
      [int? badgeCount]) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, color: Colors.teal, size: 30),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: title == 'Review Submissions' &&
                badgeCount != null &&
                badgeCount > 0
            ? badges.Badge(
                position: badges.BadgePosition.topEnd(top: -10, end: -10),
                badgeContent: Text(
                  badgeCount.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
              )
            : const Icon(Icons.arrow_forward_ios, color: Colors.teal),
        onTap: onPressed,
      ),
    );
  }
}
