import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BadgeScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Badges'),
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('badges')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var badges = snapshot.data!.docs;
          return ListView.builder(
            itemCount: badges.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(badges[index]['name']),
                subtitle: Text(badges[index]['description']),
              );
            },
          );
        },
      ),
    );
  }
}

class Badge {
  String id;
  String userId;
  String credentialId;
  DateTime issuedDate;

  Badge({
    required this.id,
    required this.userId,
    required this.credentialId,
    required this.issuedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'credentialId': credentialId,
      'issuedDate': issuedDate,
    };
  }

  Badge.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        userId = doc['userId'],
        credentialId = doc['credentialId'],
        issuedDate = (doc['issuedDate'] as Timestamp).toDate();
}
