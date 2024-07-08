import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'module_detail_screen.dart';

class LearningModuleScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Modules'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(labelText: 'Search Modules'),
            onChanged: (value) {
              // Trigger UI update
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('learning_modules').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var modules = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: modules.length,
                  itemBuilder: (context, index) {
                    var module = modules[index];
                    if (_searchController.text.isEmpty ||
                        module['title']
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase())) {
                      return ListTile(
                        title: Text(module['title']),
                        subtitle: Text(module['category']),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ModuleDetailScreen(moduleId: module.id)));
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
