import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCredentialsScreen extends StatelessWidget {
  final String adminName;

  AdminCredentialsScreen({required this.adminName});

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
        title: const Text(
          'Your Created Credentials',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('credentials')
              .where('createdBy', isEqualTo: adminName)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var credentials = snapshot.data!.docs;
            return ListView.builder(
              itemCount: credentials.length,
              itemBuilder: (context, index) {
                var credential = credentials[index];
                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      credential['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          credential['description'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Requirements:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...List<String>.from(credential['requirements'])
                            .map((requirement) => Text('- $requirement'))
                            .toList(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
