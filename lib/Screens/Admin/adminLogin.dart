import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:microcredential/Screens/Admin/HomeScreen.dart'; // Update this import path to the correct one

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _adminLogin() async {
    try {
      setState(() {
        loading = true;
      });

      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (email.isEmpty) {
        _showSnackbar('Enter your email address', Colors.red);
        setState(() {
          loading = false;
        });
        return;
      } else if (!_isValidEmail(email)) {
        _showSnackbar('Enter valid email address', Colors.red);
        setState(() {
          loading = false;
        });
        return;
      } else if (password.isEmpty) {
        _showSnackbar('Enter your password', Colors.red);
        setState(() {
          loading = false;
        });
        return;
      }

      // Fetch admin user details from Firestore
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('admin_users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isEmpty) {
        _showSnackbar('Not an admin account', Colors.red);
        setState(() {
          loading = false;
        });
        return;
      }

      // Check if password matches
      final adminData = documents[0].data() as Map<String, dynamic>;
      if (adminData['password'] != password) {
        _showSnackbar('Incorrect email or password', Colors.red);
        setState(() {
          loading = false;
        });
        return;
      }

      // Save admin state in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAdmin', true);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AdminHomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      _showSnackbar('Login failed: ${e.toString()}', Colors.red);
      setState(() {
        loading = false;
      });
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _showSnackbar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Admin Login",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/logo.png',
                height: 150,
                width: 180,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.teal),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.teal,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _adminLogin,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Login', style: TextStyle(fontSize: 16)),
              ),
              if (loading) const CircularProgressIndicator(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
