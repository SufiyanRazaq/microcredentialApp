import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;

class ModuleDetailScreen extends StatelessWidget {
  final String moduleId;

  const ModuleDetailScreen({super.key, required this.moduleId});

  void _startAssignment(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser!;
    final badgeQuery = await FirebaseFirestore.instance
        .collection('badges')
        .where('userId', isEqualTo: user.uid)
        .where('moduleId', isEqualTo: moduleId)
        .get();

    if (badgeQuery.docs.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AssignmentScreen(moduleId: moduleId),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You have already earned a badge for this module.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('learning_modules')
            .doc(moduleId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var module = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  module['title'],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  module['description'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  'Category: ${module['category']}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Difficulty: ${module['difficulty']}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Requirements:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...List<Widget>.from(
                    module['requirements'].map((req) => Text('- $req'))),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _startAssignment(context),
                  child: const Text('Start Assignment'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AssignmentScreen extends StatefulWidget {
  final String moduleId;

  const AssignmentScreen({super.key, required this.moduleId});

  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  List<QueryDocumentSnapshot> assignments = [];
  List<List<String>> shuffledOptions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  String? selectedAnswer;
  bool? isAnswerCorrect;
  PageController _pageController = PageController();

  Future<void> _downloadBadge(String badgeImage) async {
    try {
      final byteData = await rootBundle.load(badgeImage);
      final Uint8List bytes = byteData.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(bytes,
          name: path.basename(badgeImage));
      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Badge downloaded successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to download badge')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download badge: $e')));
    }
  }

  Future<void> _submitAnswers(String moduleTitle) async {
    if (correctAnswers >= 25) {
      var badgeImageMap = {
        'Basic Life Support (BLS) Certification':
            'assets/bls_certification.png',
        'Advanced Cardiac Life Support (ACLS)': 'assets/acls.png',
        'Infection Control Practices': 'assets/infection_control.png',
        'Pediatric Advanced Life Support (PALS)': 'assets/pals.png',
        'Telemedicine Best Practices': 'assets/telemedicine_best_practices.png',
        'Evidence-Based Medicine': 'assets/evidence_based_medicine.png',
        'Mental Health First Aid': 'assets/mental_health_first_aid.png',
        'Geriatric Care': 'assets/geriatric_care.png',
        'Healthcare Leadership and Management':
            'assets/healthcare_leadership.png',
        'Digital Health Innovations': 'assets/digital_health_innovations.png',
      };

      var badgeImage = badgeImageMap[moduleTitle] ?? 'assets/default_title.png';

      await FirebaseFirestore.instance.collection('badges').add({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'moduleId': widget.moduleId,
        'issuedAt': Timestamp.now(),
        'badgeImage': badgeImage,
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You have earned a badge!')));

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Congratulations!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(badgeImage),
              const SizedBox(height: 10),
              const Text('Badge is in your profile page'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _downloadBadge(badgeImage),
                child: const Text('Download Badge'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Some answers are incorrect. Try again.')));
    }
  }

  void _selectAnswer(String answer) {
    var correctAnswer = assignments[currentQuestionIndex]['answer'];
    setState(() {
      selectedAnswer = answer;
      isAnswerCorrect = (answer == correctAnswer);
      if (isAnswerCorrect!) {
        correctAnswers++;
      } else {
        wrongAnswers++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (currentQuestionIndex < assignments.length - 1) {
          currentQuestionIndex++;
          selectedAnswer = null;
          isAnswerCorrect = null;
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        } else {
          FirebaseFirestore.instance
              .collection('learning_modules')
              .doc(widget.moduleId)
              .get()
              .then((docSnapshot) {
            var moduleTitle = docSnapshot['title'];
            _submitAnswers(moduleTitle);
          });
        }
      });
    });
  }

  List<String> _shuffleOptions(List<String> options) {
    options.shuffle(Random());
    return options;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('learning_modules')
            .doc(widget.moduleId)
            .collection('assignments')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (assignments.isEmpty) {
            assignments = snapshot.data!.docs;
            shuffledOptions = assignments.map((assignment) {
              List<String> options = List<String>.from(assignment['options']);
              return _shuffleOptions(options);
            }).toList();
          }

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Answer at least 25 questions correctly to earn a badge.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    var currentQuestion = assignments[index];
                    var options = shuffledOptions[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question ${index + 1}/${assignments.length}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentQuestion['question'],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          ...options.map<Widget>((option) {
                            Color? optionColor;
                            if (selectedAnswer != null) {
                              if (option == selectedAnswer) {
                                optionColor = isAnswerCorrect!
                                    ? Colors.green
                                    : Colors.red;
                              }
                            }
                            return GestureDetector(
                              onTap: () {
                                if (selectedAnswer == null) {
                                  _selectAnswer(option);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: optionColor ?? Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  option,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            );
                          }).toList(),
                          const SizedBox(height: 20),
                          Text(
                            'Correct Answers: $correctAnswers',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Wrong Answers: $wrongAnswers',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
