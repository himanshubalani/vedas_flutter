import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vedas/pages/accountpage.dart';

class InterestsPage extends StatefulWidget {
  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  String selectedInterest = "Value";

  final List<String> interests = [ 'Theory of Computation', 'Web Development', "Advanced Wireless Sensor Networks",    "Applied Mathematics",    "Artificial Intelligence",    "Big Data Analytics and Business Intelligence",    "C Programming",    "Cloud Computing",    "Computational Geometry",    "Computer Architecture",    "Computer Graphics",    "Computer Networks",    "Cyber Security",    "Data Communication",    "Data Structures",    "Data Warehousing and Mining",    "Database Management System",    "Design and Analysis of Algorithms",    "Design Patterns",    "Digital Circuits and Fundamental of Microprocessor",    "Digital Forensics",    "Digital Image Processing",    "Distributed Operating system",    "Functional English",    "Fuzzy Logic",    "Language Processor",    "Mainframe Technologies",    "Mobile Computing",    "Natural Language Processing",    "Object Oriented Programming",    "Optimization Techniques",    "Parallel and Network Algorithm",    "Real Time Operating System",    "Software Architecture",    "Software Engineering and Project Management",    "TCP IP" ];

  void _onChipSelected(String interest) {
    setState(() {
      selectedInterest = interest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Interest'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Choose an Interest',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: interests.map((interest) {
                  return InputChip(
                    label: Text(interest),
                    selected: selectedInterest == interest,
                    selectedColor: Colors.deepPurple[200],
                    onPressed: () {
                      _onChipSelected(interest);
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: selectedInterest == null ? null : () {
                  // Call the function to update the user's interests
                  updateUserInterests([selectedInterest]);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AccountPage()));
                },
                child: const Text('Save'),
              ),
            ],
          ),
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
