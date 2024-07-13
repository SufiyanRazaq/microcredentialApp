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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Learning Modules',
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Modules',
                      prefixIcon: const Icon(Icons.search, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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

                List<QueryDocumentSnapshot<Object?>> modules =
                    snapshot.data!.docs;

                // Add debug print to check the data
                print('Number of modules: ${modules.length}');

                // Remove duplicates based on document ID
                var uniqueModules = <String, QueryDocumentSnapshot>{};
                for (var module in modules) {
                  uniqueModules[module.id] = module;
                }
                modules = uniqueModules.values.toList();

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
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Icon(
                              Icons.book,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            module['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${module['category']} - ${module['difficulty']}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
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
