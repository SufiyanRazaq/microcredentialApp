import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool loading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  Future<void> _signUp() async {
    try {
      String emailText = _emailController.text.trim();
      String passwordText = _passwordController.text.trim();
      String confirmPasswordText = _confirmPasswordController.text.trim();
      String nameText = _nameController.text.trim();

      if (nameText.isEmpty) {
        _showSnackbar("Enter your name", "Name", Colors.red);
        return;
      } else if (emailText.isEmpty) {
        _showSnackbar("Enter your email address", "Email address", Colors.red);
        return;
      } else if (!_isValidEmail(emailText)) {
        _showSnackbar("Enter your valid email address", "Valid Email address",
            Colors.red);
        return;
      } else if (passwordText.isEmpty) {
        _showSnackbar("Enter your password", "Password", Colors.red);
        return;
      } else if (passwordText.length < 6) {
        _showSnackbar("Password cannot be less than six characters", "Password",
            Colors.red);
        return;
      } else if (passwordText != confirmPasswordText) {
        _showSnackbar(
            "Passwords do not match", "Password Mismatch", Colors.red);
        return;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailText, password: passwordText);

      // Create user document in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': nameText,
        'email': emailText,
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      _showSnackbar('Sign up failed: ${e.toString()}', "Error", Colors.red);
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _googleSignup() async {
    try {
      setState(() {
        loading = true;
      });

      // Sign out from GoogleSignIn to ensure the user can select a different account
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          _showSnackbar(
              'Email already registered.', "Registration", Colors.red);
          await _auth.signOut();
        } else {
          // Create user document in Firestore
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'name': googleUser.displayName,
            'email': googleUser.email,
          });

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }
    } catch (e) {
      _showSnackbar(
          'Google signup failed: ${e.toString()}', "Error", Colors.red);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _showSnackbar(String message, String title, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$title: $message'),
      backgroundColor: backgroundColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                prefixIcon: const Icon(
                  Icons.password,
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                prefixIcon: const Icon(
                  Icons.password,
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: _toggleConfirmPasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(
                      0,
                      0,
                    ),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: TextButton(
                onPressed: _signUp,
                child: const Text('Sign Up'),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(
                      0,
                      0,
                    ),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: SignInButton(
                Buttons.google,
                text: "Signup with Google",
                onPressed: _googleSignup,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Login'),
            ),
            if (loading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
