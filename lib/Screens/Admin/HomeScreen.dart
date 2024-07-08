import 'package:flutter/material.dart';
import 'package:microcredential/Screens/Admin/credentialScreen.dart';
import 'package:microcredential/Screens/Admin/profileScreen.dart';
import 'package:microcredential/Screens/evidence.dart';

class AdminHomeScreen extends StatelessWidget {
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
              _buildMenuButton(
                context,
                'Review Submissions',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReviewSubmissionsScreen()),
                ),
              ),
              const SizedBox(height: 15),
              _buildMenuButton(
                context,
                'Create Credentials',
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
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminProfileScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
