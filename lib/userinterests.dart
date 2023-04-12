import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Function to update user interests in Cloud Firestore
Future<void> updateUserInterests(List<String> interests) async {
  // Get the current user's ID
  final user = FirebaseAuth.instance.currentUser;
  final userId = user?.uid;

  if (userId != null) {
    // Update the user profile document with the selected interests
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'interests': interests});
  }
}


// Function to get user interests from Cloud Firestore
Future<List<String>> getUserInterests() async {
  // Get the current user's ID
  final user = FirebaseAuth.instance.currentUser;
  final userId = user?.uid;

  if (userId != null) {
    // Get the user profile document from Cloud Firestore
    final userProfileDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    // Extract the interests from the user profile document
    final interests = userProfileDoc.data()?['interests'] as List<dynamic>?;
    if (interests != null) {
      return interests.cast<String>();
    }
  }
  return [];
}
