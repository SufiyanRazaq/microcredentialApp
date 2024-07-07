import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

  Future<void> _signUp() async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: _email, password: _password);
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } catch (e) {
      print(e);
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _googleSignup() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => _email = value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => _password = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
                onPressed: _googleSignup, child: Text('Signup with Google')),
            ElevatedButton(onPressed: _signUp, child: Text('Sign Up')),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
