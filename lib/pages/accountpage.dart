import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vedas/auth.dart';
import 'package:vedas/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottomnavbar.dart';
import 'interestspage.dart';
import 'loginpage.dart';
import 'package:get/get.dart';


class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;
  List<String> _interests = [];

  get image => AssetImage(
  'assets/profileplaceholder.png',
  );

  Future<void> signOut(BuildContext context) async {
    await Auth().signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Widget _profilecontainer() {
    String? photoURL = FirebaseAuth.instance.currentUser?.photoURL;
    ImageProvider imageProvider;

    if (photoURL != null && photoURL.isNotEmpty) {
      imageProvider = NetworkImage(photoURL);
    } else {
      imageProvider = AssetImage('assets/profileplaceholder.png');
    }

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: imageProvider,
        ),
      ),
    );
  }

  Widget _profilename() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          user!.displayName ?? user!.email ?? "Your Name",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget signOutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
      onPressed: () {
        signOut(context);
      },
      child: const Text('Sign Out'),
    );
  }

  Widget updateInterestsButton(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InterestsPage()));
      },
      child: const Text('Update Interest'),
    );
  }

  Widget goHomeButton(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: const Text('Go Home'),
    );
  }

  Stream<List<String>> getUserInterestsStream() {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    if (userId != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots()
          .map((doc) => (doc.data()?['interests'] as List<dynamic>?)?.cast<String>() ?? []);
    }
    return const Stream.empty();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: MyBottomNavigationBar(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                _profilecontainer(),
                _profilename(),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Text(
                  'Interest',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<String>>(
                  stream: getUserInterestsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error fetching interests', style: TextStyle(color: Colors.red),);
                    } else {
                      _interests = snapshot.data ?? [];
                      return Wrap(
                        spacing: 8.0,
                        children: _interests.map((interest) => Chip(
                          label: Text(interest),
                        )).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
            updateInterestsButton(context),
            goHomeButton(context),
            const SizedBox(height: 20),
            signOutButton(context),

          ],
        ),
      ),
      );
  }


}

// Function to update user interests in Cloud Firestore
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

// Function to handle the updating of user interests


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

// Function to get user interests from Cloud Firestore
Stream<List<String>> getUserInterestsStream() {
  final user = FirebaseAuth.instance.currentUser;
  final userId = user?.uid;
  if (userId != null) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) => (doc.data()?['interests'] as List<dynamic>?)?.cast<String>() ?? []);
  }
  return const Stream.empty();
}



class VideosController extends GetxController {
  String searchQuery = '';

  updateSearchQuery(String query) {
    searchQuery = query;
    update();
  }
}


