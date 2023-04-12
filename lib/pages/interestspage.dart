import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vedas/pages/accountpage.dart';

class InterestsPage extends StatefulWidget {
  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  List<String> selectedInterests = [];

  final List<String> interests = [
    'Computer Science',
    'Artificial Intelligence',
    'Data Science',
    'Theory of Computation',
    'Python',
    'Java',
    'Data Analysis',
    'Flutter',
    'Web Development',
    'Machine Learning',
  ];

  void _onChipSelected(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Interests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose one or more interests:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: interests.map((interest) {
                return ChoiceChip(
                  label: Text(interest),
                  selected: selectedInterests.contains(interest),
                  onSelected: (selected) {
                    _onChipSelected(interest);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: selectedInterests.isEmpty ? null : () {
                // Call the function to update the user's interests
                updateUserInterests(selectedInterests);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to update user interests
  Future<void> updateUserInterests(List<String> interests) async {
    // Get the current user's ID
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    // Update the user profile document with the selected interests
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'interests': interests});
  }
}
