import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'module_detail_screen.dart';

class LearningModuleScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Modules'),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('learning_modules').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var modules = snapshot.data!.docs;
          return ListView.builder(
            itemCount: modules.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(modules[index]['title']),
                subtitle: Text(modules[index]['category']),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ModuleDetailScreen(moduleId: modules[index].id)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
