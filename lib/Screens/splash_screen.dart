import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:microcredential/Screens/Admin/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'Authentication/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  _checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAdmin = prefs.getBool('isAdmin');
    String? adminEmail = prefs.getString('adminEmail');

    await Future.delayed(Duration(seconds: 2));

    if (adminEmail != null && isAdmin == true) {
      // Check Firestore for the admin's email
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('admin_users')
          .where('email', isEqualTo: adminEmail)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AdminHomeScreen()));
        return;
      }
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
