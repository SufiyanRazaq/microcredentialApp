import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'module_detail_screen.dart';

class LearningModuleScreen extends StatefulWidget {
  @override
  _LearningModuleScreenState createState() => _LearningModuleScreenState();
}

class _LearningModuleScreenState extends State<LearningModuleScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Modules'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search Modules',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // Trigger UI update
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: <String>[
                    'All',
                    'Emergency Medicine',
                    'Cardiology',
                    'General Medicine',
                    'Pediatrics',
                    'Telehealth',
                    'Research',
                    'Psychiatry',
                    'Geriatrics',
                    'Administration',
                    'Technology'
                  ].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('learning_modules').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var modules = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: modules.length,
                  itemBuilder: (context, index) {
                    var module = modules[index];
                    bool matchesSearch = _searchController.text.isEmpty ||
                        module['title']
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase());
                    bool matchesCategory = _selectedCategory == 'All' ||
                        module['category'] == _selectedCategory;

                    if (matchesSearch && matchesCategory) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(module['title']),
                          subtitle: Text(
                              '${module['category']} - ${module['difficulty']}'),
                          trailing: IconButton(
                            icon: Icon(
                              module['isFavorite']
                                  ? Icons.star
                                  : Icons.star_border,
                              color:
                                  module['isFavorite'] ? Colors.yellow : null,
                            ),
                            onPressed: () {
                              setState(() {
                                module.reference.update(
                                    {'isFavorite': !module['isFavorite']});
                              });
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ModuleDetailScreen(moduleId: module.id),
                              ),
                            );
                          },
                        ),
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
