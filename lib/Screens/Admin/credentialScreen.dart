import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCredentialCreationScreen extends StatefulWidget {
  @override
  _AdminCredentialCreationScreenState createState() =>
      _AdminCredentialCreationScreenState();
}

class _AdminCredentialCreationScreenState
    extends State<AdminCredentialCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<TextEditingController> _requirementsControllers = [];

  Future<void> _createCredential() async {
    // Validation
    if (_nameController.text.isEmpty) {
      _showValidationMessage('Credential name is required.');
      return;
    }
    if (_descriptionController.text.isEmpty) {
      _showValidationMessage('Description is required.');
      return;
    }
    if (_requirementsControllers.isEmpty ||
        _requirementsControllers.any((controller) => controller.text.isEmpty)) {
      _showValidationMessage('All requirements must be filled.');
      return;
    }

    try {
      List<String> requirements = _requirementsControllers
          .map((controller) => controller.text)
          .toList();

      await FirebaseFirestore.instance.collection('credentials').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'requirements': requirements,
        'createdBy': 'Admin', // Assuming admin's name is used here
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credential created successfully')));
      _nameController.clear();
      _descriptionController.clear();
      _requirementsControllers.forEach((controller) => controller.clear());
      setState(() {
        _requirementsControllers.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating credential: $e')));
    }
  }

  void _showValidationMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _requirementsControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

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
          'Admin - Create Credential',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Credential Name',
                prefixIcon: Icon(Icons.badge, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ..._requirementsControllers.map((controller) {
              int index = _requirementsControllers.indexOf(controller);
              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          labelText: 'Requirement',
                          prefixIcon: Icon(Icons.list, color: Colors.teal),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _requirementsControllers.removeAt(index);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _requirementsControllers.add(TextEditingController());
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                _requirementsControllers.isEmpty
                    ? 'Add Requirement'
                    : 'Add More Requirements',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createCredential,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Create Credential',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
