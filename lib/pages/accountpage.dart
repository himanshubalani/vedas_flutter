import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vedas/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _useruid() {
    return Text(user!.email ?? "Your Name");
  }

  Widget signOutButton() {
    return ElevatedButton(
      onPressed: () {
        signOut();
      },
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _useruid(),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            signOutButton(),
          ],
        ),
      ),
    );
  }
}
