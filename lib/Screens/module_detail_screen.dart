import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModuleDetailScreen extends StatelessWidget {
  final String moduleId;

  ModuleDetailScreen({required this.moduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Module Details'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('learning_modules')
            .doc(moduleId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var module = snapshot.data!;
          return ListView(
            children: [
              Text(module['title'], style: TextStyle(fontSize: 24)),
              Text(module['content']),
              ElevatedButton(
                onPressed: () {},
                child: Text('Mark as Complete'),
              ),
            ],
          );
        },
      ),
    );
  }
}
