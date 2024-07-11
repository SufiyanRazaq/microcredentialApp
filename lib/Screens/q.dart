import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> Signup() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty) {
      print("Enter your name");
      return;
    } else if (email.isEmpty) {
      print("Enter your email");
    } else if (password.length < 6) {
      print("Password cannot be less than 6");
    } else if (password.isEmpty) {
      print("Enter your password");
    }
    try {
      var response = await http.post(
        Uri.parse("api/apdiee"),
        headers: <String, String>{
          'ContentType': 'application/json; Charset UTF8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Number of books about http: $data.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print("signup failed $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Page",
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: passwordController,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "SignUp",
            ),
          ),
        ],
      ),
    );
  }
}
